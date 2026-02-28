extends Label

func _process(delta: float) -> void:
	text = str($"../../miner".position.y) + "m"
