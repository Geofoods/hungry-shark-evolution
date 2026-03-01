extends Node2D

const WEAPONS = [
	{"name": "Black Sword", "type": "weapon", "texture_path": "res://Sword Pack/Black Sword.png"},
	{"name": "Katana", "type": "weapon", "texture_path": "res://Sword Pack/Katana.png"},
]

var item_data: Dictionary = {}
var player_in_range: bool = false
var tooltip: Label


func _ready() -> void:
	item_data = WEAPONS[randi_range(0, WEAPONS.size() - 1)]
	$"item sprite".texture = load(item_data.texture_path)
	$"item sprite/AnimationPlayer".play("open")

	_build_tooltip()

	var area = Area2D.new()
	area.name = "PickupArea"
	var shape = CollisionShape2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 40.0
	shape.shape = circle
	area.add_child(shape)
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	add_child(area)


func _build_tooltip() -> void:
	tooltip = Label.new()
	tooltip.name = "Tooltip"
	tooltip.visible = false
	tooltip.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	tooltip.position = Vector2(-80, -90)
	tooltip.add_theme_font_size_override("font_size", 18)
	tooltip.add_theme_color_override("font_color", Color.WHITE)
	tooltip.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
	tooltip.add_theme_constant_override("shadow_offset_x", 2)
	tooltip.add_theme_constant_override("shadow_offset_y", 2)
	add_child(tooltip)


func _refresh_tooltip() -> void:
	var already_have: bool
	var slot_full: bool

	if item_data.type == "weapon":
		already_have = UserInterface.weapon != null and UserInterface.weapon.name == item_data.name
		slot_full = UserInterface.weapon != null
	else:
		already_have = (UserInterface.powerups[0] != null and UserInterface.powerups[0].name == item_data.name) \
					or (UserInterface.powerups[1] != null and UserInterface.powerups[1].name == item_data.name)
		slot_full = UserInterface.powerups[0] != null and UserInterface.powerups[1] != null

	var action: String
	if already_have:
		action = "[Already have this]"
	elif slot_full:
		action = "E - Swap"
	else:
		action = "E - Pick Up"

	tooltip.text = item_data.name + "\n" + action


func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		player_in_range = true
		_refresh_tooltip()
		tooltip.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "miner":
		player_in_range = false
		tooltip.visible = false


func _already_have() -> bool:
	if item_data.type == "weapon":
		return UserInterface.weapon != null and UserInterface.weapon.name == item_data.name
	return (UserInterface.powerups[0] != null and UserInterface.powerups[0].name == item_data.name) \
		or (UserInterface.powerups[1] != null and UserInterface.powerups[1].name == item_data.name)


func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		if _already_have():
			return
		var old_item = UserInterface.swap_item(item_data)
		InventoryUI.refresh()

		if old_item.is_empty():
			# Nothing displaced — clean pickup
			queue_free()
		else:
			# Become the dropped item so the player can pick it back up
			item_data = old_item
			$"item sprite".texture = load(item_data.texture_path)
			_refresh_tooltip()
