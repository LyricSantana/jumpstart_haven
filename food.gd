extends Area2D

@export var points: int = 10
var is_collected := false
var float_offset := 0.0
var start_y := 0.0

func _ready() -> void:
	add_to_group("collectibles")
	body_entered.connect(_on_body_entered)
	start_y = position.y

func _process(delta: float) -> void:
	if is_collected:
		return
	float_offset += delta * 3.0
	position.y = start_y + sin(float_offset) * 4.0

func _get_game_state():
	if has_node("/root/GameState"):
		return get_node("/root/GameState")
	if get_tree() and get_tree().root and get_tree().root.has_node("GameState"):
		return get_tree().root.get_node("GameState")
	return null

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player" or is_collected:
		return

	is_collected = true
	visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	body.score += 1
	if body.has_method("_update_hud"):
		body._update_hud()

	if _all_collectibles_collected():
		var state = _get_game_state()
		if state != null:
			state.set_win_state()
		get_tree().change_scene_to_file("res://start_screen.tscn")
		return

func _all_collectibles_collected() -> bool:
	for collectible in get_tree().get_nodes_in_group("collectibles"):
		if not collectible.is_collected:
			return false
	return true

func reset_collectible() -> void:
	is_collected = false
	visible = true
	monitoring = true
	monitorable = true
	position.y = start_y
	float_offset = 0.0
