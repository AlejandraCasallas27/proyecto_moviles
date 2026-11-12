
import 'dart:math';
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const PokePastelApp());
}

// COLORES DE LA APLICACIÓN
const Color rosa = Color(0xFFFFB8D2);
const Color rosaFuerte = Color(0xFFEC75AB);
const Color rosaClaro = Color(0xFFFFE5F0);
const Color lavanda = Color(0xFFC9B8F8);
const Color lilaClaro = Color(0xFFF0E9FF);
const Color menta = Color(0xFFC9F0DF);
const Color azul = Color(0xFFD9EFFF);
const Color amarillo = Color(0xFFFFEDBD);
const Color fondo = Color(0xFFFFF8FC);
const Color texto = Color(0xFF59435F);

String capitalizar(String nombre) {
  if (nombre.isEmpty) return nombre;
  return nombre[0].toUpperCase() + nombre.substring(1);
}

String imagenPokemon(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/'
      'sprites/master/sprites/pokemon/other/'
      'official-artwork/$id.png';
}

// APLICACIÓN PRINCIPAL
class PokePastelApp extends StatelessWidget {
  const PokePastelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokéPastel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: fondo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: rosaFuerte,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: fondo,
          foregroundColor: texto,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: texto,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: rosaFuerte,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: const PantallaPrincipal(),
    );
  }
}

// FONDO CON DEGRADADO
class FondoCoquette extends StatelessWidget {
  final Widget child;

  const FondoCoquette({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFF5FB),
            Color(0xFFF7F0FF),
            Color(0xFFF2FBFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}

// WIDGET PERSONALIZADO: TARJETA COQUETTE
class TarjetaPastel extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const TarjetaPastel({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: rosaFuerte.withOpacity(0.13),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }
}

// WIDGET PERSONALIZADO: ETIQUETAS
class EtiquetaPastel extends StatelessWidget {
  final String nombre;
  final Color color;

  const EtiquetaPastel({
    super.key,
    required this.nombre,
    this.color = rosaClaro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        nombre,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: texto,
          fontSize: 12,
        ),
      ),
    );
  }
}

// NAVEGACIÓN PRINCIPAL
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() =>
      _PantallaPrincipalState();
}

class _PantallaPrincipalState
    extends State<PantallaPrincipal> {
  int indice = 0;

  final pantallas = const [
    InicioScreen(),
    PokedexScreen(),
    CartasScreen(),
    AleatorioScreen(),
  ];

  final titulos = [
    'PokéPastel ♡',
    'Mi Pokédex ✿',
    'Cartitas TCG ♡',
    'Sorpresa ✨',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulos[indice]),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                rosaClaro,
                lilaClaro,
                azul,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: FondoCoquette(
        child: pantallas[indice],
      ),
      bottomNavigationBar: NavigationBar(
        height: 76,
        backgroundColor: const Color(0xFFFFF0F7),
        indicatorColor: rosa,
        selectedIndex: indice,
        onDestinationSelected: (nuevoIndice) {
          setState(() {
            indice = nuevoIndice;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(
              Icons.favorite,
              color: rosaFuerte,
            ),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon_outlined),
            selectedIcon: Icon(
              Icons.catching_pokemon,
              color: rosaFuerte,
            ),
            label: 'Pokédex',
          ),
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(
              Icons.style,
              color: rosaFuerte,
            ),
            label: 'Cartas',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(
              Icons.auto_awesome,
              color: rosaFuerte,
            ),
            label: 'Aleatorio',
          ),
        ],
      ),
    );
  }
}

// PANTALLA 1: INICIO
class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Hello, entrenadora! ♡',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: texto,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Tu rinconcito Pokémon lleno de color y magia ✨',
          style: TextStyle(
            fontSize: 15,
            color: texto,
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFBDD7),
                Color(0xFFE6D4FF),
                Color(0xFFD2EFFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: rosaFuerte.withOpacity(0.18),
                blurRadius: 22,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  EtiquetaPastel(
                    nombre: '✿ KAWAII WORLD ✿',
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.auto_awesome,
                    color: rosaFuerte,
                    size: 26,
                  ),
                ],
              ),

              Image.network(
                imagenPokemon(25),
                height: 188,
                errorBuilder: (_, __, ___) =>
                    const Icon(
                  Icons.catching_pokemon,
                  size: 100,
                ),
              ),

              const Text(
                'Tu aventura más cute ♡',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: texto,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Pokémon, cartas y sorpresas '
                'en un solo lugar',
                textAlign: TextAlign.center,
                style: TextStyle(color: texto),
              ),

              const SizedBox(height: 15),

              const Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  EtiquetaPastel(
                    nombre: '♡ POKÉDEX',
                    color: Colors.white,
                  ),
                  EtiquetaPastel(
                    nombre: '✿ TCG',
                    color: Colors.white,
                  ),
                  EtiquetaPastel(
                    nombre: '✨ RANDOM',
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Explora y diviértete ୨୧',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: texto,
          ),
        ),

        const SizedBox(height: 14),

        const TarjetaPastel(
          color: rosaClaro,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.catching_pokemon,
                color: rosaFuerte,
              ),
            ),
            title: Text(
              'Pokédex mágica',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Descubre tipos, habilidades '
              'y estadísticas.',
            ),
            trailing: Icon(
              Icons.favorite,
              color: rosaFuerte,
            ),
          ),
        ),

        const SizedBox(height: 14),

        const TarjetaPastel(
          color: menta,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.style,
                color: rosaFuerte,
              ),
            ),
            title: Text(
              'Cartas de colección',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Conoce las ilustraciones '
              'de Pokémon TCG.',
            ),
            trailing: Icon(
              Icons.auto_awesome,
              color: rosaFuerte,
            ),
          ),
        ),

        const SizedBox(height: 14),

        const TarjetaPastel(
          color: amarillo,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.casino,
                color: rosaFuerte,
              ),
            ),
            title: Text(
              'Una dulce sorpresa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '¡Encuentra un Pokémon aleatorio!',
            ),
            trailing: Icon(
              Icons.stars,
              color: rosaFuerte,
            ),
          ),
        ),
      ],
    );
  }
}

// PANTALLA 2: POKÉDEX
class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() =>
      _PokedexScreenState();
}

class _PokedexScreenState
    extends State<PokedexScreen> {
  late Future<List<dynamic>> pokemons;
  String busqueda = '';

  @override
  void initState() {
    super.initState();
    pokemons = ApiService.getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(
                Icons.favorite,
                color: rosaFuerte,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Conoce a tus Pokémon favoritos',
                  style: TextStyle(
                    fontSize: 16,
                    color: texto,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar Pokémon ♡',
              prefixIcon: const Icon(
                Icons.search,
                color: rosaFuerte,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(22),
                borderSide: const BorderSide(
                  color: rosa,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(22),
                borderSide: const BorderSide(
                  color: rosaFuerte,
                  width: 2,
                ),
              ),
            ),
            onChanged: (valor) {
              setState(() {
                busqueda = valor.toLowerCase();
              });
            },
          ),
        ),

        const SizedBox(height: 15),

        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: pokemons,
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: rosaFuerte,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                  ),
                );
              }

              final lista = (snapshot.data ?? [])
                  .where(
                    (pokemon) => pokemon['name']
                        .toString()
                        .contains(busqueda),
                  )
                  .toList();

              if (lista.isEmpty) {
                return const Center(
                  child: Text(
                    'No encontré Pokémon '
                    'con ese nombre ♡',
                  ),
                );
              }

              const colores = [
                rosaClaro,
                lilaClaro,
                azul,
                menta,
                amarillo,
              ];

              return ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  final pokemon = lista[index];
                  final nombre =
                      pokemon['name'].toString();

                  final url =
                      pokemon['url'] as String;

                  final id = int.parse(
                    Uri.parse(url)
                        .pathSegments
                        .where(
                          (parte) =>
                              parte.isNotEmpty,
                        )
                        .last,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: TarjetaPastel(
                      color:
                          colores[index % colores.length],
                      padding:
                          const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(
                          imagenPokemon(id),
                          height: 65,
                          width: 65,
                          errorBuilder:
                              (_, __, ___) =>
                                  const Icon(
                            Icons.catching_pokemon,
                            size: 45,
                          ),
                        ),
                        title: Text(
                          capitalizar(nombre),
                          style: const TextStyle(
                            fontSize: 18,
                            color: texto,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        subtitle:
                            Text('Pokémon #$id ✿'),
                        trailing: const Icon(
                          Icons.favorite_border,
                          color: rosaFuerte,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetallePokemonScreen(
                                nombre: nombre,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// PANTALLA 3: CARTAS TCG
class CartasScreen extends StatefulWidget {
  const CartasScreen({super.key});

  @override
  State<CartasScreen> createState() =>
      _CartasScreenState();
}

class _CartasScreenState
    extends State<CartasScreen> {
  late Future<List<dynamic>> cartas;

  @override
  void initState() {
    super.initState();
    cartas = ApiService.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            'Una colección llena de '
            'brillo y encanto ✨',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: texto,
            ),
          ),
        ),

        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: cartas,
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: rosaFuerte,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.cloud_off_outlined,
                        color: rosaFuerte,
                        size: 55,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No se pudieron cargar '
                        'las cartas TCG.',
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            cartas =
                                ApiService.getCards();
                          });
                        },
                        child: const Text(
                          'Intentar de nuevo',
                        ),
                      ),
                    ],
                  ),
                );
              }

              final lista = snapshot.data ?? [];

              if (lista.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay cartas para mostrar',
                  ),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final columnas =
                      constraints.maxWidth >= 700
                          ? 4
                          : 2;

                  return GridView.builder(
                    padding:
                        const EdgeInsets.all(14),
                    itemCount: lista.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnas,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final carta =
                          Map<String, dynamic>.from(
                        lista[index] as Map,
                      );

                      final imagen =
                          carta['images']?['small'];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetalleCartaScreen(
                                carta: carta,
                              ),
                            ),
                          );
                        },
                        child: TarjetaPastel(
                          color: index.isEven
                              ? rosaClaro
                              : lilaClaro,
                          padding:
                              const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                child: imagen != null
                                    ? Image.network(
                                        imagen,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (_, __, ___) =>
                                                const Icon(
                                          Icons
                                              .image_not_supported,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.style,
                                        size: 60,
                                        color: rosaFuerte,
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                carta['name'] ??
                                    'Sin nombre',
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: texto,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// PANTALLA 4: POKÉMON ALEATORIO
class AleatorioScreen extends StatefulWidget {
  const AleatorioScreen({super.key});

  @override
  State<AleatorioScreen> createState() =>
      _AleatorioScreenState();
}

class _AleatorioScreenState
    extends State<AleatorioScreen> {
  Map<String, dynamic>? pokemon;
  bool cargando = false;
  String? error;

  Future<void> obtenerAleatorio() async {
    setState(() {
      cargando = true;
      error = null;
      pokemon = null;
    });

    try {
      final id = Random().nextInt(1025) + 1;

      final resultado =
          await ApiService.getPokemon(
        id.toString(),
      );

      if (!mounted) return;

      setState(() {
        pokemon = resultado;
        cargando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.auto_awesome,
              color: rosaFuerte,
              size: 75,
            ),

            const SizedBox(height: 12),

            const Text(
              'Tu sorpresa Pokémon ♡',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: texto,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Presiona el botón y deja '
              'que la magia elija por ti ✨',
              textAlign: TextAlign.center,
              style: TextStyle(color: texto),
            ),

            const SizedBox(height: 22),

            ElevatedButton.icon(
              onPressed:
                  cargando ? null : obtenerAleatorio,
              icon: const Icon(Icons.favorite),
              label: const Text(
                '¡Sorpréndeme!',
              ),
            ),

            const SizedBox(height: 22),

            if (cargando)
              const CircularProgressIndicator(
                color: rosaFuerte,
              ),

            if (error != null)
              Text(
                'Ups, ocurrió un error: $error',
                textAlign: TextAlign.center,
              ),

            if (pokemon != null)
              ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 420,
                ),
                child: TarjetaPastel(
                  color: lilaClaro,
                  child: Column(
                    children: [
                      const EtiquetaPastel(
                        nombre:
                            '✿ ¡HOLA, QUÉ LINDO! ✿',
                        color: Colors.white,
                      ),

                      Image.network(
                        imagenPokemon(
                          pokemon!['id'],
                        ),
                        height: 205,
                        errorBuilder:
                            (_, __, ___) =>
                                const Icon(
                          Icons.catching_pokemon,
                          size: 90,
                        ),
                      ),

                      Text(
                        capitalizar(
                          pokemon!['name'],
                        ),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight:
                              FontWeight.w900,
                          color: texto,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetallePokemonScreen(
                                nombre:
                                    pokemon!['name'],
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Conocer más ♡',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// PANTALLA 5: DETALLE DE POKÉMON
class DetallePokemonScreen extends StatefulWidget {
  final String nombre;

  const DetallePokemonScreen({
    super.key,
    required this.nombre,
  });

  @override
  State<DetallePokemonScreen> createState() =>
      _DetallePokemonScreenState();
}

class _DetallePokemonScreenState
    extends State<DetallePokemonScreen> {
  late Future<Map<String, dynamic>> detalle;

  @override
  void initState() {
    super.initState();
    detalle =
        ApiService.getPokemon(widget.nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${capitalizar(widget.nombre)} ♡',
        ),
      ),
      body: FondoCoquette(
        child: FutureBuilder<Map<String, dynamic>>(
          future: detalle,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: rosaFuerte,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            }

            final datos = snapshot.data!;

            final tipos =
                (datos['types'] as List)
                    .map(
                      (item) =>
                          item['type']['name'],
                    )
                    .join(', ');

            final habilidades =
                (datos['abilities'] as List)
                    .map(
                      (item) =>
                          item['ability']['name'],
                    )
                    .join(', ');

            return ListView(
              padding: const EdgeInsets.all(18),
              children: [
                TarjetaPastel(
                  color: rosaClaro,
                  child: Column(
                    children: [
                      const EtiquetaPastel(
                        nombre:
                            '♡ POKÉMON ESPECIAL ♡',
                        color: Colors.white,
                      ),

                      Image.network(
                        imagenPokemon(
                          datos['id'],
                        ),
                        height: 235,
                        errorBuilder:
                            (_, __, ___) =>
                                const Icon(
                          Icons.catching_pokemon,
                          size: 100,
                        ),
                      ),

                      Text(
                        capitalizar(
                          datos['name'],
                        ),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.w900,
                          color: texto,
                        ),
                      ),

                      Text(
                        'Pokémon #${datos['id']} ✿',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                TarjetaPastel(
                  color: lilaClaro,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detalles mágicos ✨',
                        style: TextStyle(
                          fontSize: 19,
                          color: texto,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text('♡ Tipos: $tipos'),

                      const SizedBox(height: 10),

                      Text(
                        '✿ Habilidades: $habilidades',
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '♡ Altura: '
                        '${datos['height'] / 10} m',
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '✿ Peso: '
                        '${datos['weight'] / 10} kg',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// PANTALLA 6: DETALLE DE CARTA TCG
class DetalleCartaScreen extends StatelessWidget {
  final Map<String, dynamic> carta;

  const DetalleCartaScreen({
    super.key,
    required this.carta,
  });

  @override
  Widget build(BuildContext context) {
    final imagen = carta['images']?['large'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${carta['name'] ?? 'Carta'} ♡',
        ),
      ),
      body: FondoCoquette(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TarjetaPastel(
              color: rosaClaro,
              child: Column(
                children: [
                  const EtiquetaPastel(
                    nombre: '✨ MI CARTITA ✨',
                    color: Colors.white,
                  ),

                  const SizedBox(height: 12),

                  if (imagen != null)
                    Image.network(
                      imagen,
                      height: 330,
                      errorBuilder:
                          (_, __, ___) =>
                              const Icon(
                        Icons.style,
                        size: 100,
                      ),
                    )
                  else
                    const Icon(
                      Icons.style,
                      size: 100,
                      color: rosaFuerte,
                    ),

                  const SizedBox(height: 12),

                  Text(
                    carta['name'] ??
                        'Sin nombre',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.w900,
                      color: texto,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            TarjetaPastel(
              color: lilaClaro,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ficha de colección ♡',
                    style: TextStyle(
                      fontSize: 19,
                      color: texto,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '✿ Rareza: '
                    '${carta['rarity'] ?? 'No disponible'}',
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '♡ Supertipo: '
                    '${carta['supertype'] ?? 'N/A'}',
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '✿ PS: '
                    '${carta['hp'] ?? 'N/A'}',
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '♡ Número: '
                    '${carta['number'] ?? 'N/A'}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
