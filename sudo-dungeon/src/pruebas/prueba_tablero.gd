# Script de prueba temporal. Se adjunta a un nodo de una escena para ejecutarlo con F6.
extends Node
 
 
# _ready() se ejecuta automáticamente cuando la escena arranca.
func _ready() -> void:
	var tablero := Sudoku.crear_tablero_vacio()
	Sudoku.imprimir_tablero(tablero)
 
