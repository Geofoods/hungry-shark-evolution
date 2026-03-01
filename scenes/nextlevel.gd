extends Area2D

var levels = ["res://scenes/level2.tscn", "res://scenes/level3.tscn"]

func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		get_tree().change_scene_to_file(levels[randi_range(0,1)])
