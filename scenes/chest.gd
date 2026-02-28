extends Node2D

var playertouching = false
var opened = false
var pickableitem = preload("res://pickableitems.tscn")

func _ready() -> void:
	$AnimatedSprite2D.frame = 0
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	playertouching = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	playertouching = false
	
func _process(delta):
	if playertouching and Input.is_action_just_pressed("interact") and !opened:
		$AnimatedSprite2D.play("default")
		opened = true
		var pickableinstance = pickableitem.instantiate()
		add_child(pickableinstance)
