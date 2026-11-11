# Lógica pura del Sudoku. No depende de nodos ni de la interfaz (ver DEC-002).
class_name Sudoku
 
const TAMANO := 9          # El tablero es de 9x9
const TAMANO_BLOQUE := 3   # Cada bloque es de 3x3
const VACIA := 0           # Un 0 significa "celda vacía"
 
 
# Devuelve un tablero 9x9 relleno de ceros.
static func crear_tablero_vacio() -> Array:
	var tablero: Array = []
	for fila in range(TAMANO):
		var nueva_fila: Array = []
		for col in range(TAMANO):
			nueva_fila.append(VACIA)
		tablero.append(nueva_fila)
	return tablero
 
 
# Imprime el tablero por consola, separando los bloques 3x3.
static func imprimir_tablero(tablero: Array) -> void:
	for fila in range(TAMANO):
		# Línea horizontal entre bloques (antes de las filas 3 y 6)
		if fila != 0 and fila % TAMANO_BLOQUE == 0:
			print("------+-------+------")
		var texto := ""
		for col in range(TAMANO):
			# Barra vertical entre bloques (antes de las columnas 3 y 6)
			if col != 0 and col % TAMANO_BLOQUE == 0:
				texto += "| "
			texto += str(tablero[fila][col]) + " "
		print(texto)
 
