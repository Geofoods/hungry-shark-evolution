extends Label

func _process(_delta: float) -> void:
	var miner = get_tree().current_scene.get_node_or_null("miner")
	if miner == null:
		return
	text = str(((round(miner.position.y) + 1990) * -0.01) + -44 * UserInterface.level) + "m"
	UserInterface.downmeters = round(miner.position.y)
