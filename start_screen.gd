extends Control

@onready var title_label: Label = $Label
@onready var button_label: Label = $TextureButton/Label

func _ready() -> void:
	if has_node("TextureButton"):
		$TextureButton.pressed.connect(_on_start_pressed)
	_apply_state()


func _apply_state() -> void:
	var state = get_node("/root/GameState")
	if state == null:
		title_label.text = "The kitty is very hungry.\nEat all the food!"
		button_label.text = "Start"
		return

	title_label.text = state.screen_title
	button_label.text = state.button_text

func _on_start_pressed() -> void:
	var state = get_node("/root/GameState")
	if state != null:
		state.set_start_state()
	get_tree().change_scene_to_file("res://main.tscn")
