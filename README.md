# 💗 PokéPastel

## ¿Qué es PokéPastel?

**PokéPastel** es una aplicación móvil desarrollada en Flutter que permite explorar el mundo Pokémon de una manera interactiva, visual y entretenida.

La aplicación combina información de los Pokémon con sus cartas coleccionables, utilizando una interfaz inspirada en la estética *coquette*, caracterizada por colores pastel, tonos rosados, lilas, tarjetas redondeadas y elementos decorativos.

PokéPastel utiliza dos APIs públicas:

- **[PokéAPI](https://pokeapi.co/):** proporciona información de los Pokémon, como nombres, identificadores, tipos, habilidades, altura, peso e imágenes.
- **[TCGdex](https://tcgdex.dev/):** proporciona información e imágenes de las cartas coleccionables Pokémon TCG.

La aplicación permite consultar información de Pokémon de diferentes generaciones y explorar cartas coleccionables sin necesidad de crear una cuenta.

## Características

- **Pokédex:** colección de Pokémon populares y de diferentes generaciones.
- **Búsqueda:** permite encontrar Pokémon por nombre.
- **Detalles de Pokémon:** muestra imagen, número de identificación, tipos, habilidades, altura y peso.
- **Cartas TCG:** presenta una colección de cartas Pokémon obtenidas desde TCGdex.
- **Detalles de cartas:** permite visualizar las ilustraciones y la información disponible de cada carta.
- **Pokémon aleatorio:** utiliza la función `Random()` para seleccionar un Pokémon al azar y consultar sus datos.
- **Navegación:** cuatro secciones principales mediante una barra inferior y pantallas adicionales de detalles.
- **Widgets personalizados:** componentes reutilizables como `TarjetaPastel`, `EtiquetaPastel` y `FondoCoquette`.
- **Diseño coquette:** interfaz con colores pastel, degradados, iconos, sombras y bordes redondeados.
- **Imágenes de internet:** utilización de `Image.network()` para mostrar Pokémon y cartas.
- **Manejo de estados:** indicadores de carga, mensajes de error y actualización de datos.

## Tecnologías utilizadas

- **Flutter:** framework para el desarrollo de aplicaciones multiplataforma.
- **Dart:** lenguaje de programación utilizado en Flutter.
- **HTTP:** paquete para realizar consultas a las APIs.
- **PokéAPI:** servicio de información sobre Pokémon.
- **TCGdex:** servicio de información sobre cartas Pokémon TCG.
- **Android Studio:** entorno de desarrollo y pruebas.
- **Git y GitHub:** control de versiones y almacenamiento del código.
- **Figma:** herramienta utilizada para el diseño de la interfaz.

## Diseño visual

PokéPastel utiliza una identidad visual femenina y coquette, con una paleta de colores suaves que permite diferenciar los elementos de la interfaz.

| Color | Código hexadecimal | Uso |
|---|---|---|
| Rosa pastel | `#FFB8D2` | Tarjetas y elementos decorativos |
| Rosa intenso | `#EC75AB` | Botones e iconos destacados |
| Rosa claro | `#FFE5F0` | Fondos y contenedores |
| Lavanda | `#C9B8F8` | Elementos decorativos |
| Lila claro | `#F0E9FF` | Tarjetas y fondos secundarios |
| Verde menta | `#C9F0DF` | Tarjetas de contenido |
| Azul pastel | `#D9EFFF` | Fondos y elementos complementarios |
| Amarillo pastel | `#FFEDBD` | Tarjetas y detalles visuales |

La interfaz utiliza los widgets de Flutter para crear una experiencia sencilla, organizada y adaptable a diferentes tamaños de pantalla.

## Pantallas de la aplicación

### 1. Inicio

Presenta la aplicación PokéPastel, una ilustración de Pikachu y tarjetas informativas sobre sus funcionalidades principales.

Permite conocer las opciones disponibles en la aplicación y su temática visual.

### 2. Pokédex

Muestra una selección de Pokémon de diferentes generaciones mediante tarjetas de colores pastel.

Cada tarjeta presenta la imagen y el nombre del Pokémon, además de información complementaria.

Incluye un buscador que permite filtrar los Pokémon disponibles por nombre.

Al seleccionar un Pokémon, se abre su pantalla de detalles.

### 3. Cartas TCG

Permite explorar cartas coleccionables Pokémon obtenidas desde TCGdex.

Las cartas se presentan en una cuadrícula con ilustraciones y nombres.

Al seleccionar una carta, se abre una pantalla donde se muestra su imagen ampliada y la información disponible.

### 4. Pokémon aleatorio

Permite descubrir un Pokémon al azar mediante el botón **¡Sorpréndeme!**.

Esta funcionalidad utiliza la clase `Random()` de Dart y una consulta HTTP a PokéAPI.

Después de obtener el Pokémon, se muestra su imagen y nombre, con la opción de consultar más información.

### 5. Detalle de Pokémon

Presenta información individual del Pokémon seleccionado:

- Nombre.
- Imagen.
- Número de identificación.
- Tipos.
- Habilidades.
- Altura.
- Peso.

### 6. Detalle de carta

Muestra una ilustración ampliada de la carta seleccionada y los datos disponibles, como nombre, número, rareza y puntos de salud.

Algunos campos pueden aparecer como no disponibles según la información obtenida de la API.

## Estructura del proyecto

```text
flutter_application_1/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   └── api_service.dart
├── linux/
├── macos/
├── web/
├── windows/
├── pubspec.yaml
├── pubspec.lock
├── .gitignore
└── README.md
```

### Descripción de los archivos principales

**main.dart**

Contiene el punto de entrada de la aplicación, la configuración del tema visual, los colores, los widgets personalizados, la navegación y las pantallas.

**api_service.dart**

Contiene las funciones responsables de realizar las consultas HTTP a PokéAPI y TCGdex.

**pubspec.yaml**

Contiene la configuración general del proyecto y sus dependencias, incluido el paquete `http`.

## Instalación y ejecución

### Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install).
- Android Studio o Visual Studio Code.
- Plugins de Flutter y Dart.
- Emulador Android o dispositivo físico compatible.
- Conexión a internet.

### Pasos

**1. Clonar el repositorio**

```bash
git clone https://github.com/AlejandraCasallas27/proyecto_moviles.git
```

**2. Ingresar a la carpeta del proyecto**

```bash
cd proyecto_moviles
```

**3. Instalar las dependencias**

```bash
flutter pub get
```

**4. Ejecutar la aplicación**

```bash
flutter run
```

Para ejecutarla en Chrome:

```bash
flutter run -d chrome
```

## Despliegue de la aplicación

PokéPastel fue compilada para Android mediante Flutter y probada en un dispositivo móvil real.

Para generar el APK de distribución se utiliza:

```bash
flutter build apk --release
```

El archivo generado se encuentra en:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Este archivo permite instalar la aplicación en dispositivos Android compatibles.

La aplicación fue instalada y se comprobó su funcionamiento en un celular Android.

## Manual de uso

**1. Inicio**

Al abrir PokéPastel aparece la pantalla principal, que presenta la aplicación y sus funcionalidades.

En la parte inferior se encuentra la barra de navegación que permite acceder a las demás secciones.

**2. Pokédex**

Selecciona la pestaña **Pokédex** para explorar los Pokémon disponibles.

Utiliza el campo de búsqueda para encontrar un Pokémon por su nombre.

Toca una tarjeta para consultar sus tipos, habilidades, altura y peso.

**3. Cartas TCG**

Selecciona la pestaña **Cartas** para explorar las cartas coleccionables.

Toca una carta para visualizar su ilustración ampliada y consultar su información.

**4. Pokémon aleatorio**

Selecciona la pestaña **Aleatorio** y presiona el botón **¡Sorpréndeme!**.

La aplicación seleccionará un Pokémon al azar y mostrará su imagen y nombre.

Presiona **Conocer más** para consultar sus características.

## Widgets utilizados

La aplicación utiliza widgets básicos de Flutter, entre ellos:

- `Scaffold`
- `AppBar`
- `NavigationBar`
- `Container`
- `Column`
- `Row`
- `Text`
- `Image.network`
- `ListView`
- `GridView`
- `TextField`
- `ElevatedButton`
- `Icon`
- `Padding`
- `SizedBox`
- `CircularProgressIndicator`

También utiliza widgets personalizados:

- **TarjetaPastel:** presenta información dentro de tarjetas con colores pastel y bordes redondeados.
- **EtiquetaPastel:** crea etiquetas decorativas para identificar contenido.
- **FondoCoquette:** aplica fondos degradados a las pantallas.

## Capturas de pantalla

Las capturas de la versión final de la aplicación se incorporarán en esta sección.

Se recomienda incluir:

- Inicio.
- Pokédex.
- Cartas TCG.
- Pokémon aleatorio.
- Detalle de Pokémon.
- Detalle de carta.

## Diseño y documentación

- **Repositorio GitHub:** https://github.com/AlejandraCasallas27/proyecto_moviles
- **Diseño Figma:**(https://www.figma.com/design/wWu5Ic3mNGYwlp3Q2a7kCd/Sin-t%C3%ADtulo?node-id=0-1&t=gNtsbIQJupHLzb1J-1)
- **Documento PDF:** Agregado arriba del Readme.md

## Créditos y referencias

- Datos e imágenes de Pokémon: [PokéAPI](https://pokeapi.co/).
- Datos e imágenes de cartas coleccionables: [TCGdex](https://tcgdex.dev/).
- Desarrollo de la interfaz: [Flutter](https://flutter.dev/).
- Lenguaje de programación: [Dart](https://dart.dev/).

PokéPastel es un proyecto académico realizado con fines educativos. Pokémon y sus personajes pertenecen a sus respectivos titulares de derechos.

## Autores

**Proyecto:** PokéPastel

**Asignatura:** Desarrollo Móvil

**Integrantes:** Pendiente de completar.

**Institución:** Pendiente de completar.
