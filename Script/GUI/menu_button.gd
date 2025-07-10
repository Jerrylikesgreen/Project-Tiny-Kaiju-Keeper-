class_name GameMenuButton extends Button


func _on_pressed() -> void:
	Events.sfx_trigger(SFX.Track.BLIP)
	
