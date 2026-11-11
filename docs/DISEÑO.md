# Diseño del juego

Documento vivo. Aquí va **qué** es el juego; en DECISIONES.md va **por qué** se eligió cada cosa.

## Concepto

Cada piso de la mazmorra es una cuadrícula de 9×9 = 81 salas posibles. El contenido de cada sala lo determina un número del 1 al 9 siguiendo las reglas del Sudoku: no se repite en su fila, columna ni bloque 3×3.

## Propiedades que da el Sudoku

- Cada fila y columna contiene un tipo de sala de cada.
- Cada bloque 3×3 es un "ala" con una muestra completa de tipos.
- Siempre hay 9 salas de cada tipo, lo que facilita el balance.

## Tipos de sala (borrador)

| Nº | Sala | Notas |
|----|------|-------|
| 1 | Combate fácil | |
| 2 | Combate normal | |
| 3 | Tesoro | |
| 4 | Tienda | |
| 5 | Fogata / descanso | |
| 6 | Trampa / puzzle | |
| 7 | Evento misterioso | |
| 8 | Élite | |
| 9 | Mini-jefe | |

Jefe final: pendiente de decidir (sala especial o una de las "9").

## Mecánica central: deducción

- Al empezar el piso, solo algunas salas están reveladas (las pistas del Sudoku).
- El resto se muestra como "?" y el jugador puede deducir su tipo por lógica.
- Reliquias y objetos pueden revelar información extra.
- La dificultad se ajusta con el número de pistas iniciales.

## Navegación

- No hace falta recorrer las 81 salas.
- Las salas se conectan formando un laberinto sobre la cuadrícula, con algunos ciclos extra.

## Capa roguelite

- Muerte permanente dentro de una partida.
- Mejoras permanentes entre partidas (pistas iniciales, reliquias desbloqueables).

## Ideas para después (NO tocar hasta terminar el hito actual)

- [ ] Sudokus de otros tamaños (4×4, 16×16)
- [ ] Jefes con mecánicas de Sudoku propias
- [ ] Modo diario con semilla fija
- [ ] (añade aquí las ideas nuevas en lugar de implementarlas)
