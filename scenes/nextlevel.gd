extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		get_tree().change_scene_to_file("res://scenes/level2.tscn")
