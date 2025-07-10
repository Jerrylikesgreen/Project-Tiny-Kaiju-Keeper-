class_name SceneManager extends Node
## Root node observer. Will handle all scene transitions. 

const MAIN_SCENE = preload("res://Scene/main_scene.tscn")



func _ready() -> void:
	var main_scene = MAIN_SCENE.instantiate()
	add_child(main_scene)
	var world_manager: WorldManager = %WorldManager
