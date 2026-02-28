extends CharacterBody2D

@export var speed: float = 150.0

var direction: int = 1  # 1 = right, -1 = left

func _physics_process(delta):
	# Move shark
	velocity.x = direction * speed
	velocity.y = 0

	# Move and detect collisions
	var collision = move_and_slide()
	if is_on_wall():
		direction *= -1
		$Sprite.flip_h = direction < 0
