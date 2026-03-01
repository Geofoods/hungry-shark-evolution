extends Area2D

const DAMAGE_PER_SECOND = 12.0
const BOB_SPEED = 1.5
const BOB_AMPLITUDE = 100.0

var _origin_y: float
var _time: float = 0.0
var _player_contact: bool = false


func _ready() -> void:
	_origin_y = global_position.y
	# Randomise phase so jellyfish don't all bob in sync
	_time = randf() * TAU
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _process(delta: float) -> void:
	_time += delta
	# Bob up and down around spawn point
	global_position.y = _origin_y + (sin(_time * BOB_SPEED)-0.5) * BOB_AMPLITUDE

	if _player_contact:
		UserInterface.oxygen -= DAMAGE_PER_SECOND * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		_player_contact = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "miner":
		_player_contact = false
