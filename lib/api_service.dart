
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // LISTA DE POKÉMON DE POKÉPASTEL

  static const String _nombresPokemon = '''
pikachu charizard bulbasaur ivysaur venusaur
charmander charmeleon squirtle wartortle blastoise
eevee vaporeon jolteon flareon espeon umbreon
leafeon glaceon sylveon snorlax mewtwo mew
gengar haunter gastly dragonite lapras gyarados
arcanine psyduck jigglypuff meowth persian
machamp alakazam lucario greninja gardevoir
blaziken rayquaza lugia ho-oh celebi tyranitar
scizor heracross ditto onix steelix golem

totodile croconaw feraligatr chikorita bayleef
meganium cyndaquil quilava typhlosion ampharos
umbreon houndoom suicune entei raikou metagross
salamence flygon absol milotic sceptile swampert
mudkip torchic treecko gardevoir gallade aggron
manectric sharpedo wailord altaria banette duskull
dusclops shuppet mawile torkoal slaking breloom
ludicolo latias latios kyogre groudon jirachi
deoxys regice regirock registeel

piplup prinplup empoleon chimchar monferno
infernape turtwig grotle torterra lucario riolu
garchomp spiritomb rotom darkrai arceus dialga
palkia giratina shaymin zoroark zorua snivy
servine serperior tepig pignite emboar oshawott
dewott samurott hydreigon chandelure haxorus
volcarona excadrill krookodile darmanitan zekrom
reshiram kyurem victini meloetta genesect
bisharp mienshao scolipede leavanny whimsicott
zebstrika

froakie frogadier greninja fennekin braixen
delphox chespin quilladin chesnaught sylveon
xerneas yveltal zygarde noivern talonflame
aegislash goodra decidueye incineroar primarina
rowlet litten popplio lycanroc mimikyu solgaleo
lunala necrozma zeraora melmetal zacian
zamazenta eternatus dragapult corviknight
cinderace rillaboom inteleon toxtricity
grimmsnarl sprigatito floragato meowscarada
fuecoco crocalor skeledirge quaxly quaquaval
koraidon miraidon
''';

  // NOMBRES ESPECIALES UTILIZADOS POR POKEAPI

  static const Map<String, String> _nombresEspeciales = {
    'deoxys': 'deoxys-normal',
    'giratina': 'giratina-altered',
    'shaymin': 'shaymin-land',
    'darmanitan': 'darmanitan-standard',
    'zygarde': 'zygarde-50',
    'aegislash': 'aegislash-shield',
    'lycanroc': 'lycanroc-midday',
    'mimikyu': 'mimikyu-disguised',
    'toxtricity': 'toxtricity-amped',
  };

  static String _nombreApi(String nombre) {
    final nombreLimpio = nombre.trim().toLowerCase();

    return _nombresEspeciales[nombreLimpio] ??
        nombreLimpio;
  }

  // API 1: OBTENER LA LISTA DE POKÉMON

  static Future<List<dynamic>> getPokemons() async {
    final url = Uri.parse(
      'https://pokeapi.co/api/v2/pokemon?limit=2000',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
      json.decode(response.body);

      final List<dynamic> resultados = data['results'];

      final Map<String, dynamic> pokemonPorNombre = {};

      for (final pokemon in resultados) {
        pokemonPorNombre[pokemon['name']] = pokemon;
      }

      // Eliminar Pokémon repetidos
      final nombres = _nombresPokemon
          .trim()
          .split(RegExp(r'\s+'))
          .toSet()
          .toList();

      final List<dynamic> pokemonsSeleccionados = [];

      for (final nombre in nombres) {
        final nombreEnApi = _nombreApi(nombre);
        final pokemon = pokemonPorNombre[nombreEnApi];

        if (pokemon != null) {
          pokemonsSeleccionados.add({
            'name': nombre,
            'url': pokemon['url'],
          });
        }
      }

      if (pokemonsSeleccionados.isEmpty) {
        throw Exception(
          'No se encontraron Pokémon en la API.',
        );
      }

      return pokemonsSeleccionados;
    } else {
      throw Exception(
        'No se pudieron cargar los Pokémon. '
            'Código: ${response.statusCode}',
      );
    }
  }

  // API 1: CONSULTAR LOS DETALLES DE UN POKÉMON

  static Future<Map<String, dynamic>> getPokemon(
      String nombre,
      ) async {
    final nombreEnApi = _nombreApi(nombre);

    final url = Uri.parse(
      'https://pokeapi.co/api/v2/pokemon/$nombreEnApi',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> datos =
      json.decode(response.body);

      return datos;
    } else {
      throw Exception(
        'No se encontró el Pokémon: $nombre. '
            'Código: ${response.statusCode}',
      );
    }
  }

  // API 2: OBTENER CARTAS POKÉMON DESDE TCGDEX

  static Future<List<dynamic>> getCards() async {
    try {
      final List<dynamic> todasLasCartas = [];

      // Pokémon que aparecerán en la colección
      final nombres = [
        'Pikachu',
        'Eevee',
        'Charizard',
        'Bulbasaur',
        'Squirtle',
        'Mew',
      ];

      for (final nombre in nombres) {
        // Consultar las cartas por nombre
        final url = Uri.https(
          'api.tcgdex.net',
          '/v2/en/cards',
          {'name': nombre},
        );

        final response = await http.get(url);

        if (response.statusCode != 200) {
          throw Exception(
            'Error al consultar $nombre. '
                'Código: ${response.statusCode}',
          );
        }

        final List<dynamic> datos =
        json.decode(response.body);

        // Seleccionar hasta cuatro cartas con imagen
        final cartasConImagen = datos
            .where((carta) => carta['image'] != null)
            .take(4);

        for (final carta in cartasConImagen) {
          final String imagen = carta['image'];

          // Adaptar los campos al formato de main.dart
          todasLasCartas.add({
            'id': carta['id'],
            'name': carta['name'],
            'number': carta['localId'],
            'supertype': 'Pokémon',
            'rarity': 'No disponible',
            'hp': 'N/A',
            'images': {
              'small': '$imagen/low.png',
              'large': '$imagen/high.png',
            },
          });
        }
      }

      if (todasLasCartas.isEmpty) {
        throw Exception(
          'No se encontraron cartas con imágenes.',
        );
      }

      return todasLasCartas;
    } catch (e) {
      throw Exception(
        'No se pudieron cargar las cartas: $e',
      );
    }
  }
}
