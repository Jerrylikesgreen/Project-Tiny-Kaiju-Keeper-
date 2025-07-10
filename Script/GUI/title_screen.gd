class_name TitleScreen extends PanelContainer
## Title Screen Node


func _on_button_pressed() -> void: ## When button is pressed, triggers this function to turn Title Screen off. 
	self.hide()  # hides self and all children
	print("TitleScreen hidden:", is_visible_in_tree())
	Events.emit_signal("game_start")
	Events.game_state_change(1)
