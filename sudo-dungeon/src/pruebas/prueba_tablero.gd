# Script de prueba temporal. Se adjunta a un nodo de una escena para ejecutarlo con F6.
extends Node
 
 
# _ready() se ejecuta automáticamente cuando la escena arranca.
func _ready() -> void:
	var tablero := Sudoku.crear_tablero_vacio()
	tablero[0][0] = 5   # ponemos un 5 en la esquina
	Sudoku.imprimir_tablero(tablero)

	print("5 en la misma fila (0,5):    ", Sudoku.es_valido(tablero, 0, 5, 5))  # false
	print("5 en la misma columna (5,0): ", Sudoku.es_valido(tablero, 5, 0, 5))  # false
	print("5 en el mismo bloque (1,1):  ", Sudoku.es_valido(tablero, 1, 1, 5))  # false
	print("5 en otro sitio (4,4):       ", Sudoku.es_valido(tablero, 4, 4, 5))  # true
	print("3 junto al 5 (0,5):          ", Sudoku.es_valido(tablero, 0, 5, 3))  # true
 
