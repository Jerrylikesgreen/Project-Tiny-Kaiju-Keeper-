
extends Node

func _enter_tree() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED   # <-- 4.x name

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		toggle_pause()

func toggle_pause() -> void:
	var tree := get_tree()
	tree.paused = not tree.paused
