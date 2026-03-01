extends CharacterBody2D
# --- CONFIGURATION ---
@export var speed: float = 600.0

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		$playeranimation.rotation = input_vector.angle()+ PI/2
	# --- MOVE PLAYER ---
	velocity = input_vector * speed
	move_and_slide()
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		$CollisionShape2D.rotation = input_vector.angle() - PI/2
