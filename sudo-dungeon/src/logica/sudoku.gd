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

# Devuelve true si "num" se puede colocar en (fila, col) sin romper
# las reglas: no repetirse en su fila, columna ni bloque 3x3.
static func es_valido(tablero: Array, fila: int , col: int, num: int) -> bool:
	# 1. Fila: recorremos todas las columnas de esa fila
	for c in range(TAMANO):
		if tablero[fila][c]== num:
			return false
			
	# 2. Columna: recorremos todas las filas de esa columna
	for f in range(TAMANO):
		if tablero[f][col] == num:
			return false

	# 3. Bloque 3x3: calculamos su esquina superior izquierda y lo recorremos
	var inicio_fila := fila - (fila % TAMANO_BLOQUE)
	var inicio_col := col - col % TAMANO_BLOQUE
	for f in range(inicio_fila, inicio_fila + TAMANO_BLOQUE):
		for c in range(inicio_col, inicio_col + TAMANO_BLOQUE):
			if tablero[f][c] == num:
				return false
	
	# Ninguna comprobación encontró el número: cabe
	return true 
