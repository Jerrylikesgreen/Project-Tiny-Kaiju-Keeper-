class_name Poop extends AnimatedSprite2D


func _ready() -> void:
	Events.poop.connect(_on_poop)
	

func _on_poop(v:bool):
	if v == false:
		queue_free()
	else:
		pass
		
