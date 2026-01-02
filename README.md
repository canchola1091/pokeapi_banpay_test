# PokeApi Flutter App


## Descripción

Es una aplicación que permite a los usuarios consultar de manera inicial una lista de los primeros 100 Pokémon.
La aplicación consume la API pública [PokeAPI](https://pokeapi.co/), además del listado, de esta API se pueden obtener sus detalles de cada como Pokemon (tipos, estadísticas, habilidades, altura, peso).
Hay un fucnionlidad en la cúal se permite al usuario realizar un CRUD mediante una lista de "favoritos" la cual se almacena de manera local, ya que la API es de solo consulta.


### Características Principales

**Listado de Pokémon:** Visualiza una lista paginada de los primeros 100 Pokémon disponibles en la PokeAPI.
**Detalle de Pokémon:** Accede a información detallada de cada Pokémon, incluyendo imagen, tipos, estadísticas base, habilidades y movimientos.
**Favoritos Locales:** Agrega o elimina Pokémon de una lista personal de favoritos, almacenada localmente en el dispositivo.


## Librerías Utilizadas

- **[flutter_riverpod]:** Sistema de inyección de dependencias y gestión de estado.
- **[dio]:** Cliente HTTP para realizar solicitudes a la PokeAPI.
- **[shared_preferences]:** Almacenamiento local persistente de clave-valor para guardar la lista de favoritos.
- **[animate_do]:** Implementación de animaciones de forma sencilla.


## Instrucciones para Compilar el Proyecto

1.  **Prerrequisitos:**
    Tener instalado el SDK de Flutter (versión >= 3.24.2) y sus herramientas asociadas (Dart SDK, Android Studio/Xcode, Simulador, etc).

2.  **Clonar el Repositorio:**
    git clone  https://github.com/canchola1091/pokeapi_banpay_test
    cd <pokeapi_banpay_test>

3.  **Obtener Dependencias:**
    flutter pub get

4.  **Compilar y Ejecutar:**
    flutter run


## Datos Técnicos para Desarrolladores

- **Arquitectura:** Se ha seguido una arquitectura limpia, separando responsabilidades en capas de `data`, `domain`, y `presentation`.
- **Gestión de Estado:** Se utiliza `StateNotifierProvider` de Riverpod para manejar estados locales y asíncronos, como la carga de datos y la lista de favoritos.
- **Persistencia Local:** Se usa `SharedPreferences` para almacenar la lista de Pokémon favoritos. Para aplicaciones más complejas, se podría migrar a una base de datos local como `Hive` o `SQLite`.
- **Navegación:** Se usa `Navigator.push` y `Navigator.pop` para la navegación entre vistas.
- **Modelos:** Los modelos (`PokemonModel`, `PokemonDetailModel`, `FavoritePokemonModel`) se utilizan para mapear la respues de la API.


## Mejoras en la Aplicación

- **Paginación en Listado:** Actualmente se cargan solo los primeros 100 Pokémon. Implementar un sistema de carga infinita o paginación para mostrar más Pokémon de manera eficiente.
- **Búsqueda Global:** Añadir una barra de búsqueda en la vista de listado para la busqueda de algún Pokémon por nombre o ID.
- **Configuración Avanzada de Favoritos:** Permitir al usuario organizar sus favoritos en grupos o equipos, no solo en una única lista.
- **Manejo de Errores Robusto:** Implementar un sistema de manejo de errores global.
- **Pruebas Unitarias e Integración:** Escribir pruebas unitarias para los casos de uso y notifiers.
- **Botón de Favorito en vista del detalle:** Agregar el botón de favoritos en la vista del detalle de Pokémon.


## Cómo lo Llevaría a Otro Nivel y Tiempo de Desarrollo

Llevar PokeApp a otro nivel implicaría convertirlo en una experiencia más rica y social, posiblemente con funcionalidades de juego o comunidad.


### Posibles Mejoras de Alto Nivel:

- **Backend/API Propio:** Desarrollar un backend para alojar perfiles de usuario, equipos, batallas en tiempo real, y contenido generado por la comunidad.
- **Autenticación y Perfiles:** Implementar registro/login para que los usuarios tengan perfiles persistentes y guarden sus colecciones y progresos.
- **Realidad Aumentada (AR):** Usar herramientas como ARCore o ARKit para permitir a los usuarios "colocar" Pokémon en su entorno real.
- **Notificaciones Push:** Informar a los usuarios sobre eventos o nuevos Pokémon descubiertos.
- **Mejoras en la UI:** Realizar una interfaz más vistosa y amigable con el usuario


### Estimación de Tiempo de Desarrollo

La estimación depende en gran medida del alcance específico de las nuevas funcionalidades y del tamaño del equipo de desarrollo.

- **Implementación de Backend Básico (usuarios, autenticación, API para favoritos/colecciones):** 2-4 semanas.
- **Integración de Autenticación y Perfiles en la App:** 1-2 semanas.
- **Sistema de Batallas Simuladas (Frontend y Backend básico):** 3-5 semanas.
- **Incorporación de AR (con librería existente):** 4-6 semanas.
- **Notificaciones Push:** 1-2 semanas.