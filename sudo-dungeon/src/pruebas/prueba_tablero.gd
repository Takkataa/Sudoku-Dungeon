# Script de prueba temporal. Se adjunta a un nodo de una escena para ejecutarlo con F6.
extends Node
 
 
func _ready() -> void:
	var solucion := Sudoku.generar_tablero_completo()

	# Puzzle con solución única
	var puzzle := Sudoku.crear_puzzle_unico(solucion, 20)
	Sudoku.imprimir_tablero(puzzle)
	print("Soluciones (tope 2): ", Sudoku.contar_soluciones(puzzle.duplicate(true), 2))   # debe ser 1

	var pistas := 0
	for fila in puzzle:
		for valor in fila:
			if valor != Sudoku.VACIA:
				pistas += 1
	print("Pistas: ", pistas)   # 30, o algo más si no pudo llegar

	# Prueba contraria: con 10 pistas al azar hay varias soluciones
	var ambiguo := Sudoku.crear_puzzle(solucion, 10)
	print("Soluciones del puzzle de 10 pistas (tope 2): ",
		Sudoku.contar_soluciones(ambiguo.duplicate(true), 2))                            # debe ser 2
