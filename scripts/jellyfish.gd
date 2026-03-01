extends Area2D

const DAMAGE_PER_SECOND = 12.0
const BOB_SPEED = 1.5
const BOB_AMPLITUDE = 100.0

var _player_contact: bool = false
@export var enemyhealth = 100
@onready var _origin_y = global_position.y

func _ready() -> void:
	
	# Randomise phase so jellyfish don't all bob in sync
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _process(_delta) -> void:
	# Bob up and down around saspawn point
	global_position.y = _origin_y + (sin(BOB_SPEED)-0.5) * BOB_AMPLITUDE

	if _player_contact and !$GPUParticles2D2.emitting:
		$GPUParticles2D2.emitting = true
		UserInterface.oxygen -= DAMAGE_PER_SECOND


func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		_player_contact = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "miner":
		_player_contact = false
