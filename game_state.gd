extends Node

var screen_title: String = "The kitty is very hungry.\nEat all the food!"
var button_text: String = "Start"

func set_start_state() -> void:
	screen_title = "The kitty is very hungry.\nEat all the food!"
	button_text = "Start"

func set_win_state() -> void:
	screen_title = "You did it!\nThe kitty is full!"
	button_text = "Restart"
