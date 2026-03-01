extends Area2D

var levels = ["res://scenes/level2.tscn", "res://scenes/level3.tscn"]

func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		UserInterface.level += 1
		var depth = str(snappedf(((body.position.y + 1990) * -0.01) + -44.0 * (UserInterface.level - 1), 0.1)) + "m"
		LayerPopup.show_layer(UserInterface.level, depth)
		get_tree().change_scene_to_file(levels[randi_range(0, 1)])
