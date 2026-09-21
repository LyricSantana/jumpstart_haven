extends Area2D

@export var points: int = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Food collected! Total: %d" % body.score)
		body.score += points
		queue_free()
