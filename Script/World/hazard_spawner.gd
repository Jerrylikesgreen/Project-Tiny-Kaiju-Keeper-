class_name HazardSpawner
extends Control

const COOKIE_HAZARD = preload("res://Scene/cookie_hazard.tscn")
const POOP_HAZARD   = preload("res://Scene/poop_hazard.tscn")

enum SpawnLocation { SPAWN_1, SPAWN_2, SPAWN_3 }

@onready var spawn_1: Control = %HazardSpawnerLocation1
@onready var spawn_2: Control = %HazardSpawnerLocation2
@onready var spawn_3: Control = %HazardSpawnerLocation3

@export var _is_running: bool
@onready var timer_spawner: Timer = %TimerSpawner

var _spawn_nodes: Dictionary
var _last_spawn: SpawnLocation = SpawnLocation.SPAWN_3

var _pools := {
	COOKIE_HAZARD: [],
	POOP_HAZARD:   [],
}

func _ready() -> void:
	Events.mini_game_started.connect(_on_start)

	# Make sure the timer actually calls us
	timer_spawner.timeout.connect(_on_timer_spawner_timeout)

	randomize()
	_spawn_nodes = {
		SpawnLocation.SPAWN_1: spawn_1,
		SpawnLocation.SPAWN_2: spawn_2,
		SpawnLocation.SPAWN_3: spawn_3,
	}

	# Pre‑warm pools
	_pools[COOKIE_HAZARD].append(_make_instance(COOKIE_HAZARD))
	_pools[POOP_HAZARD].append(_make_instance(POOP_HAZARD))


# -------------------------------------------------------
# Public
# -------------------------------------------------------
func spawn_hazard() -> void:
	var res    := _pick_hazard_resource()
	var hazard := _fetch_from_pool(res)
	var loc    := _pick_location()
	_activate(hazard, _spawn_nodes[loc].global_position)


# -------------------------------------------------------
# Helpers
# -------------------------------------------------------
func _pick_hazard_resource() -> PackedScene:
	return COOKIE_HAZARD if randf() < 0.70 else POOP_HAZARD

func _pick_location() -> SpawnLocation:
	var locs := SpawnLocation.values()
	locs.erase(_last_spawn)
	_last_spawn = locs[randi() % locs.size()]
	return _last_spawn

func _make_instance(res: PackedScene) -> Area2D:
	return res.instantiate() as Area2D

func _fetch_from_pool(res: PackedScene) -> Area2D:
	_pools[res] = _pools[res].filter(func(h): return is_instance_valid(h))
	for h in _pools[res]:
		if h.get_parent() == null:
			return h
	var new_h := _make_instance(res)
	_pools[res].append(new_h)
	return new_h

func _screen_to_world(cam: Camera2D, screen_pos: Vector2) -> Vector2:
	var half_vp: Vector2 = get_viewport().size * 0.5 * cam.zoom
	return cam.global_position + (screen_pos - half_vp) * cam.zoom


# -------------------------------------------------------
# Core
# -------------------------------------------------------
func _activate(hazard: Area2D, screen_pos: Vector2) -> void:
	var cam := get_viewport().get_camera_2d()
	if cam == null:
		push_error("No active Camera2D found!")
		return

	var world_pos: Vector2 = _screen_to_world(cam, screen_pos)

	if hazard.get_parent() == null:
		get_tree().current_scene.add_child(hazard)

	hazard.reactivate(world_pos)

	# Debug
	print("Spawn @", world_pos, "cam @", cam.global_position)


# -------------------------------------------------------
# Signals
# -------------------------------------------------------
func _on_start() -> void:
	_is_running = true
	timer_spawner.one_shot = false
	timer_spawner.start()
	print("Spawner running:", !timer_spawner.is_stopped())

func _on_timer_spawner_timeout() -> void:
	if _is_running:
		print("Timer tick")
		spawn_hazard()
