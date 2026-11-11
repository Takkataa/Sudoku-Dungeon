# Roadmap

Reglas del juego de planificación:

1. Una tarea = de 1 a 3 horas. Si es mayor, se divide.
2. Máximo 2 tareas "En curso" a la vez.
3. Un hito no se cierra hasta cumplir su **criterio de terminado**.
4. Ideas nuevas van a la lista "Ideas para después" de DISEÑO.md, no al hito actual.
5. Anota estimación y tiempo real de cada tarea para mejorar tus cálculos.

Cada tarea se convierte en un Issue de GitHub asignado a su Milestone.

## Resumen de hitos

| Versión | Hito | Estado |
|---------|------|--------|
| v0.1.0 | Lógica del Sudoku | ⬜ Pendiente |
| v0.2.0 | Mapa visual | ⬜ Pendiente |
| v0.3.0 | Navegación | ⬜ Pendiente |
| v0.4.0 | Salas sin combate | ⬜ Pendiente |
| v0.5.0 | Combate por turnos | ⬜ Pendiente |
| v0.6.0 | Capa roguelite | ⬜ Pendiente |
| v1.0.0 | Juego completo y pulido | ⬜ Pendiente |

---

## v0.1.0: Lógica del Sudoku

**Objetivo:** generar un tablero válido y un puzzle por consola, sin gráficos.
**Qué aprendes:** arrays 2D, recursión, backtracking, separar lógica de presentación.

**Criterio de terminado:** se genera un Sudoku completo válido, se produce un puzzle quitando celdas, y hay pruebas que lo comprueban.

| # | Tarea | Est. | Real |
|---|-------|------|------|
| 1 | Configurar entorno (Git, Godot, VS Code) y primer commit | 2 h | |
| 2 | Representar el tablero 9×9 (array 2D) y función para imprimirlo | 1 h | |
| 3 | Función `es_valido(tablero, fila, col, num)` | 2 h | |
| 4 | Generador completo con backtracking (orden aleatorio) | 3 h | |
| 5 | Función para quitar celdas según número de pistas | 2 h | |
| 6 | Comprobar que el puzzle tiene solución única (contador de soluciones) | 3 h | |
| 7 | Pruebas por consola: validar 100 tableros generados | 2 h | |
| 8 | Cerrar hito: CHANGELOG, tag `v0.1.0` | 0,5 h | |

---

## v0.2.0: Mapa visual

**Objetivo:** ver la cuadrícula 9×9 en pantalla.
**Qué aprendes:** escenas y nodos, `GridContainer`, señales, conectar lógica con interfaz.

**Criterio de terminado:** al ejecutar el juego se ve el tablero con las salas reveladas mostrando su número y las ocultas mostrando "?".

| # | Tarea | Est. | Real |
|---|-------|------|------|
| 1 | Escena de una sala (`Sala.tscn`) con su número y estado | 2 h | |
| 2 | Escena del piso: cuadrícula 9×9 de salas | 2 h | |
| 3 | Conectar el generador con la escena (revelar/ocultar) | 2 h | |
| 4 | Diferenciar visualmente los 9 tipos (color o icono provisional) | 2 h | |
| 5 | Resaltar los bloques 3×3 | 1 h | |
| 6 | Cerrar hito | 0,5 h | |

---

## v0.3.0: Navegación

**Objetivo:** convertir la cuadrícula en una mazmorra explorable.
**Qué aprendes:** grafos, algoritmos de laberinto (DFS/árbol de expansión), estado de juego.

**Criterio de terminado:** el jugador se mueve solo entre salas conectadas, las visitadas se marcan y al entrar se revela su contenido.

| # | Tarea | Est. | Real |
|---|-------|------|------|
| 1 | Estructura de conexiones entre salas (grafo) | 2 h | |
| 2 | Generar laberinto con DFS | 3 h | |
| 3 | Añadir ciclos extra | 1 h | |
| 4 | Dibujar conexiones/puertas | 2 h | |
| 5 | Mover al jugador entre salas adyacentes conectadas | 2 h | |
| 6 | Estado de sala (oculta, visible, visitada) y revelado al entrar | 2 h | |
| 7 | Cerrar hito | 0,5 h | |

---

## v0.4.0: Salas sin combate

**Objetivo:** que tesoro, descanso, tienda, trampa y evento funcionen.
**Qué aprendes:** recursos de Godot, estadísticas, inventario, diseño de sistemas.

**Criterio de terminado:** el jugador tiene vida, oro e inventario, y cada sala sin combate produce su efecto.

| # | Tarea | Est. | Real |
|---|-------|------|------|
| 1 | Datos del jugador (vida, oro, inventario) | 2 h | |
| 2 | Interfaz (HUD) con vida y oro | 2 h | |
| 3 | Sala de descanso | 1 h | |
| 4 | Sala de tesoro y tabla de objetos | 3 h | |
| 5 | Sala de tienda | 3 h | |
| 6 | Sala de trampa | 2 h | |
| 7 | Sala de evento misterioso | 3 h | |
| 8 | Cerrar hito | 0,5 h | |

---

## v0.5.0: Combate por turnos

**Objetivo:** un combate completo, ganable y perdible.
**Qué aprendes:** máquinas de estados, datos de enemigos, equilibrio básico.

**Criterio de terminado:** entrar en una sala de combate lleva a una batalla por turnos; ganar da recompensa, perder termina la partida.

| # | Tarea | Est. | Real |
|---|-------|------|------|
| 1 | Datos de enemigos (recursos) | 2 h | |
| 2 | Escena de combate y flujo de turnos | 3 h | |
| 3 | Acciones del jugador (atacar, defender, objeto) | 3 h | |
| 4 | IA simple del enemigo | 2 h | |
| 5 | Recompensas y derrota | 2 h | |
| 6 | Variantes: combate fácil, normal, élite y mini-jefe | 3 h | |
| 7 | Cerrar hito | 0,5 h | |

---

## v0.6.0: Capa roguelite

**Objetivo:** que haya partidas repetibles con progreso entre ellas.
**Qué aprendes:** guardado de datos, progresión, reliquias.

**Criterio de terminado:** morir reinicia la partida con un piso nuevo; hay mejoras permanentes guardadas en disco.

| # | Tarea | Est. | Real |
|---|-------|------|------|
| 1 | Flujo de partida: menú, run, muerte, resultados | 3 h | |
| 2 | Reliquias de información (revelar sala, fila o bloque) | 3 h | |
| 3 | Moneda permanente y tienda de mejoras | 3 h | |
| 4 | Guardado y carga | 2 h | |
| 5 | Progresión de pisos y dificultad (menos pistas) | 3 h | |
| 6 | Jefe final | 3 h | |
| 7 | Cerrar hito | 0,5 h | |

---

## v1.0.0: Juego completo

**Objetivo:** pulir y cerrar.
**Criterio de terminado:** se puede jugar de principio a fin sin errores graves, con sonido y arte coherente.

| # | Tarea | Est. | Real |
|---|-------|------|------|
| 1 | Arte definitivo (o paquete de assets coherente) | variable | |
| 2 | Sonido y música | 4 h | |
| 3 | Tutorial | 3 h | |
| 4 | Balance y pruebas de partida completas | 6 h | |
| 5 | Exportar y publicar (por ejemplo, itch.io) | 3 h | |
