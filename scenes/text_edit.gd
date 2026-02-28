extends Label

func _process(delta: float) -> void:
	text = str(round($"../../miner".position.y)+974) + "m"
