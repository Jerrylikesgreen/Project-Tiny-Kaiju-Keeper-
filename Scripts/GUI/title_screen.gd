class_name TitleScreen extends PanelContainer
## Title Screen Node


func _on_button_pressed() -> void: ## When button is pressed, triggers this function to turn Title Screen off. 
	set_visible(false)
	Events.emit_signal("start_game")
