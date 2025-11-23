class_name TitleScreen extends PanelContainer
## Title Screen Node

const MAIN_SCENE = preload("uid://c7sg24y01v6xn")

func _on_button_pressed() -> void: ## When button is pressed, triggers this function to turn Title Screen off. 
	Events.game_state_change(GameStateMachine.GameState.MAIN)
	
	get_tree().change_scene_to_packed(MAIN_SCENE)
	
