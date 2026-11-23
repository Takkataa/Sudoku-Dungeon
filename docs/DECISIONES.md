# Registro de decisiones

Cada vez que elijas algo importante, añade una entrada. Dentro de unos meses te servirá para recordar **por qué** algo está como está y si merece la pena cambiarlo.

Reglas:
- Entradas cortas (5 a 10 líneas).
- Nunca borres una entrada antigua; si cambias de opinión, añade una nueva y marca la anterior como *Reemplazada*.
- Numeración correlativa.

---

## Plantilla

```
## DEC-000: Título corto

- Fecha: AAAA-MM-DD
- Estado: Aceptada | Reemplazada por DEC-XXX
- Contexto: qué problema o pregunta había.
- Opciones consideradas:
  1. Opción A: pros / contras
  2. Opción B: pros / contras
- Decisión: qué elegí.
- Motivo: por qué.
- Consecuencias: qué implica, qué tendría que revisar si cambio de idea.
```

---

## DEC-001: Godot 4 con GDScript

- Fecha: 11/11/2026
- Estado: Aceptada
- Contexto: elegir motor y lenguaje para un roguelite 2D, primer proyecto grande.
- Opciones consideradas:
  1. Godot + GDScript: integrado, mucha documentación, poca fricción. Lenguaje menos conocido.
  2. Godot + C#: lenguaje conocido por muchos y tipado fuerte, pero exige la versión .NET y hay menos ejemplos.
  3. Unity (C#): más recursos, pero más pesado para un 2D sencillo.
- Decisión: Godot 4 estándar con GDScript.
- Motivo: menor fricción de configuración y mejor para aprender.
- Consecuencias: si más adelante hace falta rendimiento extra o C#, habría que migrar scripts.

## DEC-002: Lógica del Sudoku separada de la interfaz

- Fecha: 11/11/2026
- Estado: Aceptada
- Contexto: el generador de Sudoku es el núcleo del juego.
- Decisión: la lógica vive en `src/logica/` y no usa nodos, escenas ni señales de la interfaz.
- Motivo: se puede probar por consola, reutilizar y cambiar la interfaz sin tocarla.
- Consecuencias: la interfaz debe comunicarse con la lógica solo mediante llamadas a sus funciones y datos.

## DEC-003: Editor externo VS Code

- Fecha: 11/11/2026
- Estado: Aceptada
- Decisión: escribir código en VS Code con `godot-tools`; usar Godot para escenas y ejecución.
- Motivo: es el editor con el que ya trabajo.

## DEC-004: Logica primer iusses Tablero 9x9

- Fecha: 11/11/2026
- Estado: Aceptada
- Decisión: El talbero es un array 2d, una lista de 9 filas y cada fila es una lista de 9 numeros, el 0 Significa celda vacia.
- Motivo: De esta manera el array solo utiliza numeros y no un valor " Sin dato".

## DEC-005: Funciones de lógica como `static`

- Fecha: 2026-11-22
- Estado: Aceptada
- Contexto: las funciones del Sudoku (`crear_tablero_vacio`, `imprimir_tablero`, `es_valido`...) trabajan con un tablero que reciben como dato y no necesitan guardar nada por sí solas.
- Opciones consideradas:
  1. Funciones `static`, que se llaman directamente como `Sudoku.es_valido(...)`: no hay que crear ningún objeto y la lógica queda separada de la interfaz. La clase no puede guardar estado propio.
  2. Una clase normal con instancia (`var s = Sudoku.new()`): permitiría guardar el tablero dentro del objeto, pero obliga a crearlo y pasarlo por todas partes.
  3. Un nodo con el script adjunto (autoload): accesible desde cualquier escena, pero la lógica pasaría a depender del motor y sería más difícil de probar sola.
- Decisión: opción 1. La clase `Sudoku` solo contiene funciones `static` y constantes, y el tablero se pasa como parámetro.
- Motivo: es lo más simple, no depende de nodos ni escenas (ver DEC-002), y se puede probar con una escena mínima. Además, un tablero es un dato que viaja entre funciones, no algo que la clase deba poseer.
- Consecuencias: si una función llamada sin `static` no se encuentra, el análisis de Godot lo avisa (error `Static function ... not found`). Si más adelante hiciera falta guardar estado del piso (por ejemplo, salas visitadas), eso irá en otra clase aparte y no en `Sudoku`.

## DEC-006: Generación del tablero por backtracking con orden aleatorio

- Fecha: 2026-11-22
- Estado: Aceptada
- Contexto: hace falta generar un Sudoku completo y válido para cada piso, y que sea distinto en cada partida.
- Opciones consideradas:
  1. Backtracking recursivo probando los números 1-9 en orden aleatorio: sencillo, usa `es_valido` y siempre termina con un tablero correcto. Puede retroceder bastante en algunos casos.
  2. Generar permutaciones de filas y corregir conflictos después: menos retrocesos, pero mucho más complejo de escribir y entender.
  3. Partir de un tablero base fijo y transformarlo (intercambiar filas, columnas y dígitos): muy rápido, pero la variedad es limitada y se reconocen patrones.
- Decisión: opción 1. La función `rellenar` busca la primera celda vacía, prueba los números en orden aleatorio y, si se atasca, deshace y prueba otro.
- Motivo: es el algoritmo más fácil de entender y de ajustar, y la velocidad es más que suficiente para un tablero 9x9. Importa más aprender y poder modificarlo que optimizarlo ahora.
- Consecuencias: `rellenar` modifica el tablero en el sitio (los arrays se pasan por referencia en GDScript). El mismo mecanismo de contar soluciones se reutilizará para comprobar que el puzzle tiene solución única (issue 6). Si el rendimiento llegara a ser un problema, se podría pasar a la opción 3.

## DEC-007: Puzzle a partir de una copia, quitando celdas de una lista barajada

- Fecha: 2026-11-22
- Estado: Aceptada
- Contexto: hay que convertir el tablero completo (la solución) en un puzzle con algunas celdas vacías, que en el juego serán las salas ocultas "?". La solución original debe conservarse intacta, porque indica qué hay realmente en cada sala.
- Opciones consideradas:
  1. Copiar el tablero y vaciar celdas tomadas de una lista barajada con las 81 posiciones: nunca repite una celda, el número de pistas queda exacto y el código es corto.
  2. Elegir celdas al azar una a una (fila y columna aleatorias) hasta vaciar las necesarias: hay que comprobar si la celda ya estaba vacía, y el número de intentos no está acotado.
  3. Vaciar celdas en un patrón simétrico: los puzzles parecen más "diseñados", pero reduce la variedad y complica el código.
- Decisión: opción 1. `crear_puzzle(solucion, pistas)` trabaja sobre `solucion.duplicate(true)` y vacía las primeras `81 - pistas` posiciones de una lista barajada. El número de pistas se limita con `clampi` al rango 0-81.
- Motivo: garantiza el número exacto de pistas sin bucles de reintento, deja la solución sin tocar y permite ajustar la dificultad con un solo parámetro.
- Consecuencias: quitar celdas al azar no asegura que el puzzle tenga una única solución. Eso se comprobará en el issue 6 con un contador de soluciones. Si se quisiera otra forma de elegir celdas (por ejemplo, simétrica), solo habría que cambiar cómo se construye la lista de posiciones.

## DEC-008: Unicidad del puzzle comprobada contando soluciones con tope de 2

- Fecha: 2026-11-22
- Estado: Aceptada
- Contexto: la mecánica central del juego es deducir qué hay en cada sala. Si el puzzle admite varias soluciones, la deducción deja de ser justa.
- Opciones consideradas:
  1. Contar soluciones con backtracking y detenerse al llegar a 2: reutiliza la lógica del generador, es fácil de entender y basta para distinguir "única" de "múltiple".
  2. Resolver con técnicas lógicas humanas (candidatos únicos, parejas, etc.): garantiza que el puzzle se pueda deducir sin adivinar, pero es mucho más largo de programar.
  3. No comprobar y aceptar cualquier puzzle: lo más simple, pero rompe la equidad de la mecánica.
- Decisión: opción 1. `contar_soluciones(tablero, limite)` y `crear_puzzle_unico`, que vacía las celdas de una en una y devuelve la celda a su sitio si el puzzle deja de ser único.
- Motivo: da la garantía mínima necesaria (una sola solución) con poco código y reaprovecha lo ya aprendido.
- Aclaración (añadida el 2026-11-23): el número de pistas que se pide a `crear_puzzle_unico` es un **objetivo, no una garantía**. La función parte del tablero completo y va vaciando celdas una a una, devolviendo a su sitio las que harían perder la unicidad. Se detiene al alcanzar las pistas pedidas o al agotar todas las celdas, así que puede devolver más pistas de las pedidas (por ejemplo, pedir 20 y obtener 24 o 26). Lo que sí está garantizado es que el resultado siempre tiene una única solución.
- Limitación conocida: el método es voraz (decide celda a celda sin mirar adelante) y depende del orden aleatorio, así que dos ejecuciones con el mismo objetivo pueden dar números de pistas distintos.
- Uso en el juego: para saber cuántas pistas tiene realmente un puzzle, hay que contarlas después de generarlo, y no fiarse del valor pedido. Rango de dificultad orientativo: unas 30 pistas (fácil) hasta 24-26 (difícil). Por debajo de eso, la generación se ralentiza y rara vez llega.
- Consecuencias: una única solución no implica que se pueda deducir sin probar; si en las pruebas de juego resultan injustos, habrá que valorar la opción 2. Con pocas pistas la generación se ralentiza, y `crear_puzzle_unico` puede devolver más pistas de las pedidas. Cuanto menos pistas, más lenta es la creación del piso.