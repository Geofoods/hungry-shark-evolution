extends CanvasLayer

func _process(delta: float) -> void:
	if UserInterface.oxygen < 0:
		visible = true
		get_tree().paused = true


func _on_button_pressed() -> void:
	transition.transition("res://scenes/level.tscn")
	UserInterface.oxygen = 100
	UserInterface.level = 0
	visible = false
	get_tree().paused = false
