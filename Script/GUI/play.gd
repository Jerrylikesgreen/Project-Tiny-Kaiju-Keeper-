class_name PlayButton extends Button




func _on_pressed() -> void:
	Events.sfx_trigger(SFX.Track.BLIP)
	Globals.save_game()
	Events.mini_game_started_signal()
	SceneManager.goto_mini_game()
	
	
