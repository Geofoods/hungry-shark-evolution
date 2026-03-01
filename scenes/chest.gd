extends Node2D

var playertouching = false
var opened = false
var pickableitem = preload("res://pickableitems.tscn")

var _prompt: Control


func _ready() -> void:
	$AnimatedSprite2D.frame = 0
	_build_prompt()


func _build_prompt() -> void:
	# Root container sitting above the chest in world space
	_prompt = Control.new()
	_prompt.visible = false
	_prompt.position = Vector2(-55, -75)
	_prompt.custom_minimum_size = Vector2(110, 36)
	add_child(_prompt)

	# Key box background
	var key_panel = Panel.new()
	key_panel.position = Vector2(0, 0)
	key_panel.custom_minimum_size = Vector2(30, 30)

	var key_style = StyleBoxFlat.new()
	key_style.bg_color = Color(0.15, 0.15, 0.2, 0.92)
	key_style.border_color = Color(0.75, 0.75, 0.75, 1.0)
	key_style.set_border_width_all(2)
	key_style.corner_radius_top_left = 4
	key_style.corner_radius_top_right = 4
	key_style.corner_radius_bottom_left = 4
	key_style.corner_radius_bottom_right = 4
	key_panel.add_theme_stylebox_override("panel", key_style)

	var key_label = Label.new()
	key_label.text = "E"
	key_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	key_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	key_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	key_label.add_theme_font_size_override("font_size", 15)
	key_label.add_theme_color_override("font_color", Color.WHITE)
	key_panel.add_child(key_label)
	_prompt.add_child(key_panel)

	# "Open" text next to the key
	var text_label = Label.new()
	text_label.text = "Open"
	text_label.position = Vector2(36, 5)
	text_label.add_theme_font_size_override("font_size", 14)
	text_label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.9, 1.0))
	text_label.add_theme_constant_override("outline_size", 2)
	text_label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.85))
	_prompt.add_child(text_label)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		playertouching = true
		if not opened:
			_prompt.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "miner":
		playertouching = false
		_prompt.visible = false


func _process(_delta: float) -> void:
	if playertouching and Input.is_action_just_pressed("interact") and not opened:
		$AnimatedSprite2D.play("default")
		opened = true
		_prompt.visible = false
		var pickableinstance = pickableitem.instantiate()
		add_child(pickableinstance)
