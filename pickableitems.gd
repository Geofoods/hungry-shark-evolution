extends Node2D

var items = ["res://Sword Pack/Black Sword.png", "res://Sword Pack/Katana.png"]

func _ready() -> void:
	
	$"item sprite/AnimationPlayer".play("open")
