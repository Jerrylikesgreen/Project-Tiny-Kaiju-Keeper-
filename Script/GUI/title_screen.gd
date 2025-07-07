class_name TitleScreen extends PanelContainer
## Title Screen Node


func _on_button_pressed() -> void: ## When button is pressed, triggers this function to turn Title Screen off. 
	Events.game_state_change(1)
	Events.emit_signal("game_start")
	set_visible(false)
	
