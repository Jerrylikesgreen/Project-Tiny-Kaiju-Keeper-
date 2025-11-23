class_name PetButton extends Button


func _ready() -> void:
	
	if Globals.new_game:
		pass
	else:
		queue_free()
