# Pruebas automáticas de la lógica del Sudoku. Se ejecuta con F6.
extends Node

const NUM_TABLEROS := 100   # tableros completos a generar
const NUM_PUZZLES := 20     # puzzles a generar (es más lento: comprueba unicidad)
const PISTAS := 30


func _ready() -> void:
	print("Ejecutando pruebas (puede tardar unos segundos)...")
	var inicio := Time.get_ticks_msec()

	_probar_que_la_prueba_detecta_errores()

	# 1. Tableros completos
	var tableros_ok := 0
	var solucion: Array
	for i in range(NUM_TABLEROS):
		solucion = Sudoku.generar_tablero_completo()
		if Sudoku.es_tablero_valido(solucion):
			tableros_ok += 1

	# 2 y 3. Puzzles: unicidad y coherencia con su solución
	var unicos := 0
	var coherentes := 0
	for i in range(NUM_PUZZLES):
		solucion = Sudoku.generar_tablero_completo()
		var puzzle := Sudoku.crear_puzzle_unico(solucion, PISTAS)
		if Sudoku.contar_soluciones(puzzle.duplicate(true), 2) == 1:
			unicos += 1
		if _es_coherente(puzzle, solucion):
			coherentes += 1

	var segundos := (Time.get_ticks_msec() - inicio) / 1000.0
	print("Tableros válidos:       %d/%d" % [tableros_ok, NUM_TABLEROS])
	print("Puzzles con 1 solución: %d/%d" % [unicos, NUM_PUZZLES])
	print("Puzzles coherentes:     %d/%d" % [coherentes, NUM_PUZZLES])
	print("Tiempo: %.1f s" % segundos)


# Los números visibles del puzzle deben coincidir con los de la solución.
func _es_coherente(puzzle: Array, solucion: Array) -> bool:
	for f in range(Sudoku.TAMANO):
		for c in range(Sudoku.TAMANO):
			if puzzle[f][c] != Sudoku.VACIA and puzzle[f][c] != solucion[f][c]:
				return false
	return true


# Una prueba que nunca falla no sirve de nada: comprobamos que SÍ detecta un tablero roto.
func _probar_que_la_prueba_detecta_errores() -> void:
	var roto := Sudoku.generar_tablero_completo()
	roto[0][0] = roto[0][1]   # repetimos un número en la primera fila
	if Sudoku.es_tablero_valido(roto):
		print("ERROR: el validador no detectó un tablero roto")
	else:
		print("OK: el validador detecta tableros rotos")
