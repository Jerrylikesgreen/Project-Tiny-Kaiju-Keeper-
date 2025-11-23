class_name Click_Pet extends Area2D


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		print("input click")    # should print immediately


func _on_mouse_entered() -> void:
	print("Cldsd")
