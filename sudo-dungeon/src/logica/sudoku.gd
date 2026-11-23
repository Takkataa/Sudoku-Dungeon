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

static func buscar_celda_vacia(tablero: Array) -> Vector2i:
	for f in range(TAMANO):
		for c in range(TAMANO):
			if tablero[f][c] == VACIA:
				return Vector2i(f, c)
	return Vector2i(-1, -1)

static func rellenar(tablero: Array) -> bool:
	var celda := buscar_celda_vacia(tablero)

	# Caso base: no quedan celdas vacías, el tablero está completo
	if celda.x == -1:
		return true

	# Los números 1-9 en orden aleatorio
	var numeros: Array = range(1, TAMANO + 1)
	numeros.shuffle()

	for num in numeros:
		if es_valido(tablero, celda.x, celda.y, num):
			tablero[celda.x][celda.y] = num       # probamos este número
			if rellenar(tablero):                 # paso recursivo
				return true                       # todo lo demás encajó
			tablero[celda.x][celda.y] = VACIA     # no funcionó: deshacemos

	# Ningún número sirvió en esta celda: avisamos hacia atrás
	return false

static func generar_tablero_completo() -> Array:
	var tablero := crear_tablero_vacio()
	rellenar(tablero)
	return tablero

# Devuelve una copia de "solucion" con solo "pistas" celdas visibles.
# No modifica la solución original.
static func crear_puzzle(solucion: Array, pistas: int) -> Array:
	var total := TAMANO * TAMANO
	pistas = clampi(pistas, 0, total)   # evita valores absurdos (negativos o > 81)

	var puzzle: Array = solucion.duplicate(true)

	# Lista con todas las posiciones, barajada
	var posiciones: Array = []
	for f in range(TAMANO):
		for c in range(TAMANO):
			posiciones.append(Vector2i(f, c))
	posiciones.shuffle()

	# Vaciamos las primeras (total - pistas) posiciones de la lista barajada
	for i in range(total - pistas):
		var pos: Vector2i = posiciones[i]
		puzzle[pos.x][pos.y] = VACIA

	return puzzle

# Cuenta cuántas soluciones tiene el tablero, deteniéndose al llegar a "limite".
# Modifica el tablero mientras prueba, pero lo deja como estaba al terminar.
static func contar_soluciones(tablero: Array, limite: int = 2) -> int:
	var celda := buscar_celda_vacia(tablero)

	# Caso base: tablero completo = encontramos una solución
	if celda.x == -1:
		return 1

	var total := 0
	for num in range(1, TAMANO + 1):
		if es_valido(tablero, celda.x, celda.y, num):
			tablero[celda.x][celda.y] = num
			total += contar_soluciones(tablero, limite - total)
			tablero[celda.x][celda.y] = VACIA   # deshacemos siempre
			if total >= limite:
				break                           # ya hay suficientes, paramos

	return total

# Como crear_puzzle, pero solo vacía una celda si el puzzle sigue teniendo
# una única solución. Si no se puede llegar a "pistas" sin perder la unicidad,
# devuelve el puzzle con las pistas mínimas que logró.
static func crear_puzzle_unico(solucion: Array, pistas: int) -> Array:
	var total := TAMANO * TAMANO
	pistas = clampi(pistas, 0, total)

	var puzzle: Array = solucion.duplicate(true)

	var posiciones: Array = []
	for f in range(TAMANO):
		for c in range(TAMANO):
			posiciones.append(Vector2i(f, c))
	posiciones.shuffle()

	var pistas_actuales := total
	for elemento in posiciones:
		if pistas_actuales <= pistas:
			break
		var pos: Vector2i = elemento
		var anterior: int = puzzle[pos.x][pos.y]
		puzzle[pos.x][pos.y] = VACIA

		# Con una copia, para que el conteo no toque nuestro puzzle
		if contar_soluciones(puzzle.duplicate(true), 2) == 1:
			pistas_actuales -= 1                    # sigue siendo único: la dejamos vacía
		else:
			puzzle[pos.x][pos.y] = anterior         # ya no es único: la restauramos

	return puzzle