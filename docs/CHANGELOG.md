# Changelog

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).
Versionado: `0.MINOR.PATCH` hasta el lanzamiento `1.0.0`.

## [Sin publicar]

### Añadido
- Estructura inicial del proyecto y documentación de planificación.

---

## [Sin publicar]

## [0.1.0] - 2026-11-23

### Añadido
- Tablero 9x9 con celda vacía representada por 0, e impresión por consola con los bloques separados.
- `es_valido`: comprueba que un número no se repite en su fila, columna ni bloque 3x3.
- Generador de tableros completos por backtracking con orden aleatorio.
- `crear_puzzle`: vacía celdas sobre una copia de la solución según las pistas pedidas.
- `contar_soluciones` y `crear_puzzle_unico`: puzzles con una única solución garantizada.
- `es_tablero_valido` y escena de pruebas (`pruebas_sudoku.tscn`) que valida 100 tableros y 20 puzzles.
- Documentación inicial: ROADMAP, DISEÑO y registro de decisiones (DEC-001 a DEC-010).

### Notas
- El número de pistas pedido a `crear_puzzle_unico` es un objetivo: puede devolver más si no logra bajar sin perder la unicidad (ver DEC-008).
- Las pruebas se ejecutan a mano con F6 (ver DEC-009).


<!--
PLANTILLA para cada versión nueva (copia, pega encima de la anterior y rellena):

## [0.X.0] - AAAA-MM-DD

### Añadido
- Qué funcionalidades nuevas hay.

### Cambiado
- Qué comportamiento existente se modificó.

### Corregido
- Qué errores se arreglaron.

### Notas
- Deuda técnica o cosas pendientes que quedan.
-->