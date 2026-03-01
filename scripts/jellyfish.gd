extends Area2D

const DAMAGE_PER_SECOND = 12.0
const BOB_SPEED = 1.5
const BOB_AMPLITUDE = 100.0

var _origin_y: float
var _time: float = 0.0
var _player_contact: bool = false
@export var enemyhealth = 100


func _ready() -> void:
	_origin_y = global_position.y
	# Randomise phase so jellyfish don't all bob in sync
	_time = randf() * TAU
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _process(delta: float) -> void:
<<<<<<< Updated upstream
	$ProgressBar.value = enemyhealth
=======
	# Lazily capture origin — spawner sets global_position AFTER _ready fires
	if not _initialized:
		_origin = global_position
		_initialized = true
	$ProgressBar.value = enemyhealth

>>>>>>> Stashed changes
	_time += delta
	# Bob up and down around spawn point
	global_position.y = _origin_y + (sin(_time * BOB_SPEED)-0.5) * BOB_AMPLITUDE

<<<<<<< Updated upstream
	if _player_contact:
		UserInterface.oxygen -= DAMAGE_PER_SECOND * delta
=======
	if _player_contact and !$GPUParticles2D2.emitting and $Timer.is_stopped():
		$Timer.start()
		UserInterface.oxygen -= DAMAGE_PER_SECOND
		UserInterface.knockback = -10
		$GPUParticles2D2.emitting = true
>>>>>>> Stashed changes


func _on_body_entered(body: Node2D) -> void:
	if body.name == "miner":
		_player_contact = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "miner":
		_player_contact = false


func _on_area_entered(area: Area2D) -> void:
	if area.name == "attackarea":
		enemyhealth -= UserInterface.damage
		if enemyhealth < 0:
			queue_free()
			UserInterface.oxygen += 50
			if UserInterface.oxygen > 100:
				UserInterface.oxygen = 100
