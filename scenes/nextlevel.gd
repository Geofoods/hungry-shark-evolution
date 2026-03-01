extends Area2D

var levels = ["res://scenes/level2.tscn", "res://scenes/level3.tscn", "res://scenes/level4.tscn"]

func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		UserInterface.level += 1
		LayerPopup.show_layer(UserInterface.level)
		var idx = clamp(UserInterface.level - 1, 0, levels.size() - 1)
		get_tree().change_scene_to_file(levels[idx])
