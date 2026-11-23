# Script de prueba temporal. Se adjunta a un nodo de una escena para ejecutarlo con F6.
extends Node
 
 
# _ready() se ejecuta automáticamente cuando la escena arranca.
func _ready() -> void:
	var solucion := Sudoku.generar_tablero_completo()
	var puzzle := Sudoku.crear_puzzle(solucion, 20)

	print("Solución:")
	Sudoku.imprimir_tablero(solucion)
	print("Puzzle (20 pistas):")
	Sudoku.imprimir_tablero(puzzle)

	# Contamos las pistas para comprobarlo
	var pistas := 0
	for fila in puzzle:
		for valor in fila:
			if valor != Sudoku.VACIA:
				pistas += 1
	print("Pistas en el puzzle: ", pistas)
 
