extends CharacterBody2D # Use KinematicBody2D in Godot 3.x

# --- CONFIGURATION ---
@export var speed: float = 600.0 # Movement speed in pixels/sec

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# --- GET INPUT ---
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# --- NORMALIZE FOR DIAGONALS ---
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	# --- MOVE PLAYER ---
	velocity = input_vector * speed
	move_and_slide()
