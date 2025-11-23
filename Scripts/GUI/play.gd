class_name PlayButton extends Button




func _on_pressed() -> void:
	Events.sfx_trigger(SFX.Track.BLIP)
	Globals.save_game()
	Events.start_mini_game()
	SceneManager.goto_mini_game()
	
	
