extends CharacterBody2D

# Movement variables
@export var walk_speed: float = 200.0
@export var jump_force: float = -350.0
@export var gravity: float = 900.0

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal movement
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * walk_speed

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Move the character
	move_and_slide()
