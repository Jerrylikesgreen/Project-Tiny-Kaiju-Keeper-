class_name HazardSpawner
extends Node

const COOKIE_HAZARD = preload("res://Scene/cookie_hazard.tscn")
const POOP_HAZARD = preload("res://Scene/poop_hazard.tscn")

enum SpawnLocation { SPAWN_1, SPAWN_2, SPAWN_3 }

@export var spawn_1 : Node2D
@export var spawn_2 : Node2D
@export var spawn_3 : Node2D
@export var _is_running : bool 
@onready var timer_spawner: Timer = %TimerSpawner

var _spawn_nodes : Dictionary      ## Stores the 3 locator nodes
var _last_spawn : SpawnLocation = SpawnLocation.SPAWN_3

## One pool per hazard type
var _pools := {
	
	COOKIE_HAZARD : [],
	POOP_HAZARD   : [],
}

func _ready() -> void:
	Events.mini_game_started.connect(_on_start)
	randomize()                    
	_spawn_nodes = {
		SpawnLocation.SPAWN_1: spawn_1,
		SpawnLocation.SPAWN_2: spawn_2,
		SpawnLocation.SPAWN_3: spawn_3,
	}
	## Pre‑warm each pool with one instance (optional)
	_pools[COOKIE_HAZARD].append(_make_instance(COOKIE_HAZARD))
	_pools[POOP_HAZARD].append(_make_instance(POOP_HAZARD))

## Public API ----------------------------------------------------------------
func spawn_hazard() -> void:
	var res     := _pick_hazard_resource()
	var hazard  := _fetch_from_pool(res)
	var loc     := _pick_location()
	_activate(hazard, _spawn_nodes[loc].global_position)
## Helpers -------------------------------------------------------------------
func _pick_hazard_resource() -> PackedScene:
	var choose_cookie := randf() < 0.70
	return COOKIE_HAZARD if choose_cookie else POOP_HAZARD


func _pick_location() -> SpawnLocation:
	var locs := SpawnLocation.values()
	locs.erase(_last_spawn)                       ## Avoid's duplicates
	_last_spawn = locs[randi() % locs.size()]
	return _last_spawn

func _make_instance(res: PackedScene) -> Node2D:
	return res.instantiate() as Node2D

func _fetch_from_pool(res: PackedScene) -> Area2D:
	_pools[res] = _pools[res].filter(func(h): return is_instance_valid(h))   # <─ 1
	for h in _pools[res]:
		if h.get_parent() == null:                                           # <─ 2
			return h
	var new_h := _make_instance(res)
	_pools[res].append(new_h)
	return new_h


func _on_timer_timeout() -> void:
	spawn_hazard()


func _activate(hazard: Area2D, pos: Vector2) -> void:
	hazard.position   = pos
	hazard.visible    = true
	hazard.monitoring = true
	add_child(hazard)


func _on_start()->void:
	_is_running = true
	timer_spawner.start()
