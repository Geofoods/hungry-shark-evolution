extends CanvasLayer

func _ready() -> void:
	$highscore.text = "Highscore: " + str(((UserInterface.downmeters + 1990) * -0.01) + -44 * UserInterface.level) + "m"
func _process(delta: float) -> void:
	if UserInterface.oxygen <= 0:
		visible = true
		get_tree().paused = true

@onready var player = get_tree().get_first_node_in_group("player")
func _on_button_pressed() -> void:
	UserInterface.weapon = null
	UserInterface.oxygen = 100
	UserInterface.level = 0
	InventoryUI.restart()
	transition.transition("res://scenes/level.tscn")
	visible = false
