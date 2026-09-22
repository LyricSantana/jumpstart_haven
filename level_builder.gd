extends TileMapLayer

const TILE = Vector2i(1, 0)

func _ready() -> void:
	clear()
	for x in range(-30, 45):
		set_cell(Vector2i(x, 6), 0, TILE)

	for x in range(10, 22):
		set_cell(Vector2i(x, 3), 0, TILE)

	for x in range(24, 35):
		set_cell(Vector2i(x, 1), 0, TILE)

	for x in range(37, 50):
		set_cell(Vector2i(x, 3), 0, TILE)

	for x in range(52, 66):
		set_cell(Vector2i(x, 1), 0, TILE)
