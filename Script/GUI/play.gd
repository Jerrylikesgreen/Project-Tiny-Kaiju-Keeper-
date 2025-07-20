class_name PlayButton extends Button




func _on_pressed() -> void:
	Events.sfx_trigger(SFX.Track.BLIP)
	SceneManager.goto_mini_game()
	
	
