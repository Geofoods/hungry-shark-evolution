extends Label

# Must match inventory_ui.gd
const SLOT_SIZE = 80
const MARGIN = 20
const SPACING = 10
const SLOT_COUNT = 3
const SLOT_LABEL_HEIGHT = 28
const VIEWPORT_HEIGHT = 1080

func _ready() -> void:
	var inventory_width = SLOT_COUNT * SLOT_SIZE + (SLOT_COUNT - 1) * SPACING
	var x = MARGIN + inventory_width + SPACING * 2
	var y = VIEWPORT_HEIGHT - MARGIN - SLOT_SIZE - SLOT_LABEL_HEIGHT
	offset_left = x
	offset_top = y
	offset_right = x + 160
	offset_bottom = y + 30
	add_theme_font_size_override("font_size", 18)
	add_theme_color_override("font_color", Color.WHITE)
	add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
	add_theme_constant_override("shadow_offset_x", 2)
	add_theme_constant_override("shadow_offset_y", 2)

func _process(_delta: float) -> void:
	text = str((round($"../../miner".position.y) + 974) * 0.01) + "m"
