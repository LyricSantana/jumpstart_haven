extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -275.0
const WALK_SWAP_TIME = 0.15
const FALL_LIMIT = 300.0

const CAT_NORMAL = preload("res://assets/catNormal1.png")
const CAT_ALT = preload("res://assets/catNormal2.png")

@onready var sprite: Sprite2D = $Sprite2D

var walk_timer := 0.0
var use_alt_sprite := false
var score: int = 0
var start_position: Vector2

func _ready() -> void:
	start_position = global_position
	print("Score: %d" % score)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		walk_timer += delta
		if walk_timer >= WALK_SWAP_TIME:
			walk_timer = 0.0
			use_alt_sprite = not use_alt_sprite
		sprite.texture = CAT_ALT if use_alt_sprite else CAT_NORMAL
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		walk_timer = 0.0
		use_alt_sprite = false
		sprite.texture = CAT_NORMAL

	move_and_slide()

	if global_position.y > FALL_LIMIT:
		global_position = start_position
		velocity = Vector2.ZERO
		walk_timer = 0.0
		use_alt_sprite = false
		sprite.texture = CAT_NORMAL
		