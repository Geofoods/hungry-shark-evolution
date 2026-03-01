extends CharacterBody2D

@export var speed: float = 600.0

@onready var anim: AnimatedSprite2D = $playeranimation
@onready var weapon_pivot: Node2D = $WeaponPivot
@onready var weapon_sprite: Sprite2D = $WeaponPivot/WeaponSprite
@onready var weapon_anim: AnimationPlayer = $WeaponPivot/WeaponAnimPlayer

var _equipped_weapon_name: String = ""
var _swing_offset: float = 0.0
var _is_swinging: bool = false

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		anim.rotation = input_vector.angle() + PI / 2
		$CollisionShape2D.rotation = input_vector.angle() - PI / 2
		if anim.animation != &"swim":
			anim.play("swim")
	else:
		if anim.animation != &"idle":
			anim.play("idle")

	velocity = input_vector * speed
	move_and_slide()

	# Weapon tracks cursor — flip pivot on the left so sword stays upright
	var to_cursor = get_global_mouse_position() - global_position
	if to_cursor.x >= 0.0:
		weapon_pivot.scale.x = 1.0
		weapon_pivot.rotation = to_cursor.angle() + _swing_offset
	else:
		weapon_pivot.scale.x = -1.0
		weapon_pivot.rotation = -atan2(to_cursor.y, -to_cursor.x) + _swing_offset

	_update_weapon()

	if Input.is_action_just_pressed("attack"):
		if UserInterface.weapon != null and not _is_swinging:
			_do_swing()
<<<<<<< Updated upstream:scripts/player.gd
func reset() -> void:
	weapon_sprite.visible = false
	_equipped_weapon_name = ""
	_swing_offset = 0.0
	_is_swinging = false
	
=======
			$attackarea.monitoring = true
			$attackarea.monitorable = true
			$attacktimer.start()


>>>>>>> Stashed changes:scripts/character_body_2d.gd
func _do_swing() -> void:
	_is_swinging = true
	var tween = create_tween()
	# Wind up behind
	tween.tween_property(self, "_swing_offset", -0.9, 0.07) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Slash forward fast
	tween.tween_property(self, "_swing_offset", 1.1, 0.13) \
		.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	# Snap back to rest
	tween.tween_property(self, "_swing_offset", 0.0, 0.1) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func(): _is_swinging = false)


func _update_weapon() -> void:
	var w = UserInterface.weapon
	if w == null:
		weapon_sprite.visible = false
		_equipped_weapon_name = ""
		return

	weapon_sprite.visible = true
	if w.name != _equipped_weapon_name:
		weapon_sprite.texture = load(w.texture_path)
		_equipped_weapon_name = w.name
		weapon_anim.play("weapon/pickup")
<<<<<<< Updated upstream:scripts/player.gd
=======
	if not weapon_anim.is_playing():
		weapon_sprite.scale = Vector2(4, 4)


func _on_attacktimer_timeout() -> void:
	$attackarea.monitoring = false
	$attackarea.monitorable = false
>>>>>>> Stashed changes:scripts/character_body_2d.gd
