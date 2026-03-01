extends CharacterBody2D

@export var speed: float = 600.0

@onready var anim: AnimatedSprite2D = $playeranimation
@onready var weapon_pivot: Node2D = $WeaponPivot
@onready var weapon_sprite: Sprite2D = $WeaponPivot/WeaponSprite
@onready var weapon_anim: AnimationPlayer = $WeaponPivot/WeaponAnimPlayer

var _equipped_weapon_name: String = ""

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		$CollisionShape2D.rotation = input_vector.angle() - PI / 2
		if anim.animation != &"swim":
			anim.play("swim")
	else:
		if anim.animation != &"idle":
			anim.play("idle")

	velocity = input_vector * speed
	move_and_slide()

	# Always face cursor
	var to_cursor = get_global_mouse_position() - global_position
	anim.rotation = to_cursor.angle() + PI / 2
	weapon_pivot.rotation = to_cursor.angle()

	# Sync weapon sprite to current inventory slot
	_update_weapon()

	# Swing on left click
	if Input.is_action_just_pressed("attack"):
		if UserInterface.weapon != null and not weapon_anim.is_playing():
			weapon_anim.play("weapon/swing")


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
