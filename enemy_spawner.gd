extends Node

const JELLYFISH_SCENE = preload("res://scenes/first layer/jellyfish.tscn")
const STINGRAY_SCENE = preload("res://scenes/stingray.tscn")

const JELLYFISH_COUNT = 6
const STINGRAY_COUNT = 4
# Don't spawn within this radius of the player's start position
const MIN_DIST_FROM_PLAYER = 350.0

var _last_scene: Node = null


func _process(_delta: float) -> void:
	var current = get_tree().current_scene
	if current != null and current != _last_scene:
		_last_scene = current
		call_deferred("_spawn_enemies")


func _spawn_enemies() -> void:
	var root = get_tree().current_scene
	if root == null:
		return

	var tilemap = _find_tilemap(root)
	var player = root.get_node_or_null("miner")

	if tilemap == null or player == null:
		return

	var used_cells = tilemap.get_used_cells()
	if used_cells.is_empty():
		return

	# Build a set for fast membership checks
	var occupied: Dictionary = {}
	for cell in used_cells:
		occupied[cell] = true

	# World-space bounds from tilemap cells (accounting for tilemap scale/position)
	var min_cell = used_cells[0]
	var max_cell = used_cells[0]
	for cell in used_cells:
		if cell.x < min_cell.x: min_cell.x = cell.x
		if cell.y < min_cell.y: min_cell.y = cell.y
		if cell.x > max_cell.x: max_cell.x = cell.x
		if cell.y > max_cell.y: max_cell.y = cell.y

	# Convert cell bounds to world positions, inset 3 cells from edges
	var world_min = tilemap.to_global(tilemap.map_to_local(min_cell + Vector2i(3, 3)))
	var world_max = tilemap.to_global(tilemap.map_to_local(max_cell - Vector2i(3, 3)))

	var player_pos = player.global_position

	_spawn_group(JELLYFISH_SCENE, JELLYFISH_COUNT, root, tilemap, occupied, player_pos, world_min, world_max)
	_spawn_group(STINGRAY_SCENE, STINGRAY_COUNT, root, tilemap, occupied, player_pos, world_min, world_max)


func _spawn_group(
	scene: PackedScene,
	count: int,
	root: Node,
	tilemap: Node,
	occupied: Dictionary,
	player_pos: Vector2,
	world_min: Vector2,
	world_max: Vector2
) -> void:
	var spawned = 0
	var attempts = 0
	var max_attempts = count * 30

	while spawned < count and attempts < max_attempts:
		attempts += 1
		var candidate = Vector2(
			randf_range(world_min.x, world_max.x),
			randf_range(world_min.y, world_max.y)
		)

		if candidate.distance_to(player_pos) < MIN_DIST_FROM_PLAYER:
			continue

		if not _is_open(candidate, tilemap, occupied):
			continue

		var instance = scene.instantiate()
		root.add_child(instance)
		instance.global_position = candidate
		spawned += 1


func _is_open(world_pos: Vector2, tilemap: Node, occupied: Dictionary) -> bool:
	# Sample the candidate position plus four neighbours — all must be empty tiles
	var offsets = [Vector2.ZERO, Vector2(50, 0), Vector2(-50, 0), Vector2(0, 50), Vector2(0, -50)]
	for offset in offsets:
		var local = tilemap.to_local(world_pos + offset)
		var cell = tilemap.local_to_map(local)
		if occupied.has(cell):
			return false
	return true


func _find_tilemap(node: Node) -> Node:
	if node.get_class() == "TileMapLayer":
		return node
	for child in node.get_children():
		var result = _find_tilemap(child)
		if result != null:
			return result
	return null
