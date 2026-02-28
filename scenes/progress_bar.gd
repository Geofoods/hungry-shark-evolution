extends ProgressBar

var game_over = false

func _process(delta):
	value = UserInterface.oxygen
	UserInterface.oxygen -= 0.01
	
	if UserInterface.oxygen <= 0 and not game_over:
		game_over = true
		get_node("/root/level/User Interface/Sprite2D").visible = true
		get_tree().paused = true
