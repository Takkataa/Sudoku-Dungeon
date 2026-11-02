# Sudoku Dungeon

Roguelite de mazmorras donde cada piso es un Sudoku 9×9. Cada celda es una sala, y su número (1-9) define su tipo. El jugador deduce por lógica qué hay detrás de las puertas que aún no ha abierto.

> Estado: en desarrollo temprano. Versión actual: ver [CHANGELOG](CHANGELOG.md).

## Idea en una frase

Las reglas del Sudoku (sin repetir números en filas, columnas y bloques 3×3) equilibran la generación del piso y convierten la exploración en un puzzle de deducción.

## Tecnología

- Motor: Godot 4.x (versión estándar)
- Lenguaje: GDScript
- Editor: Visual Studio Code + extensión `godot-tools`
- Control de versiones: Git + GitHub

## Estructura del repositorio

```
docs/       Planificación, decisiones y diseño
src/logica/ Lógica pura (Sudoku, generación). No depende de la interfaz
scenes/     Escenas de Godot
assets/     Arte, sonido, fuentes
```

## Documentación

- [ROADMAP](docs/ROADMAP.md): hitos, tareas y criterios de terminado
- [DECISIONES](docs/DECISIONES.md): registro de decisiones técnicas y de diseño
- [DISEÑO](docs/DISEÑO.md): reglas del juego y tipos de sala
- [CHANGELOG](CHANGELOG.md): historial de versiones

## Cómo ejecutarlo

1. Instala Godot 4.x.
2. Clona este repositorio.
3. Abre Godot, pulsa *Importar* y selecciona `project.godot`.
4. Ejecuta con F5.

## Flujo de trabajo

- `main` siempre funciona.
- Una rama por tarea: `feature/nombre-corto`.
- Commits con prefijo: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.
- Cada hito terminado se etiqueta con una versión (`v0.1.0`, `v0.2.0`...).
