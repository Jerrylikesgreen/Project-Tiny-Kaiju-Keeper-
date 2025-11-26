class_name PoopDisplay extends Control


func _ready() -> void:
	Events.poop_signal.connect(_on_poop)
	

func _on_poop(v:bool):
	if v == false:
		queue_free()
	else:
		pass
		
