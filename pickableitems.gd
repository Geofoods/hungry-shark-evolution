extends Node2D

var items = ["res://Sword Pack/Black Sword.png", "res://Sword Pack/Katana.png"]

func _ready() -> void:
	$"item sprite".texture = load(items[randi_range(0,1)])
	$"item sprite/AnimationPlayer".play("open")
