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