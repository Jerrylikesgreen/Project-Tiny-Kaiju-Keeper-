class_name TitleScreen extends PanelContainer
## Title Screen Node

func _ready() -> void:
	if !Globals.new_game:
		set_visible(false)
		Events.mini_game_ended_signal()

func _on_button_pressed() -> void: ## When button is pressed, triggers this function to turn Title Screen off. 
	self.hide()  # hides self and all children
	print("TitleScreen hidden:", is_visible_in_tree())
	if !Globals.new_game:
		Events.mini_game_ended_signal()
	Events.emit_signal("game_start")
	Events.game_state_change(1)
