class_name HazardSpawner
extends Node

const COOKIE := preload("res://Scene/cookie.tscn")
const POOP  := preload("res://Scene/poop.tscn")

enum SpawnLocation { SPAWN_1, SPAWN_2, SPAWN_3 }

@export var spawn_1 : Node2D
@export var spawn_2 : Node2D
@export var spawn_3 : Node2D


var _spawn_nodes : Dictionary      ## Stores the 3 locator nodes
var _last_spawn : SpawnLocation = SpawnLocation.SPAWN_3

## One pool per hazard type
var _pools := {
	COOKIE : [],
	POOP   : [],
}

func _ready() -> void:
	randomize()                    ## Make RNG non‑deterministic
	_spawn_nodes = {
		SpawnLocation.SPAWN_1: spawn_1,
		SpawnLocation.SPAWN_2: spawn_2,
		SpawnLocation.SPAWN_3: spawn_3,
	}
	## Pre‑warm each pool with one instance (optional)
	_pools[COOKIE].append(_make_instance(COOKIE))
	_pools[POOP].append(_make_instance(POOP))

## Public API ----------------------------------------------------------------
func spawn_hazard() -> void:
	var res := _pick_hazard_resource()            ## COOKIE or POOP
	var hazard := _fetch_from_pool(res)
	var loc := _pick_location()

	hazard.global_position = _spawn_nodes[loc].global_position
	if hazard.get_parent() == null:               ## Only add once
		add_child(hazard)

## Helpers -------------------------------------------------------------------
func _pick_hazard_resource() -> PackedScene:
	var choose_cookie := (randi() % 2) == 0
	return COOKIE if choose_cookie else POOP


func _pick_location() -> SpawnLocation:
	var locs := SpawnLocation.values()
	locs.erase(_last_spawn)                       ## Avoid's duplicates
	_last_spawn = locs[randi() % locs.size()]
	return _last_spawn

func _make_instance(res: PackedScene) -> Node2D:
	return res.instantiate() as Node2D

func _fetch_from_pool(res: PackedScene) -> Node2D:
	for h in _pools[res]:
		if h.get_parent() == null:       
			return h
	
	## All busy → make a fresh one
	var new_h := _make_instance(res)
	new_h.mini_game = true
	_pools[res].append(new_h)
	return new_h


func _on_timer_timeout() -> void:
	spawn_hazard()
