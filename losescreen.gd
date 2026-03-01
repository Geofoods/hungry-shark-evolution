extends CanvasLayer

func _ready() -> void:
	$highscore.text = "Highscore: " + str(((UserInterface.downmeters + 1990) * -0.01) + -44 * UserInterface.level) + "m"
func _process(delta: float) -> void:
	if UserInterface.oxygen <= 0:
		visible = true
		get_tree().paused = true


func _on_button_pressed() -> void:
	transition.transition("res://scenes/level.tscn")
	UserInterface.oxygen = 100
	UserInterface.level = 0
	visible = false
