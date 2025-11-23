extends Label

func _ready() -> void:
	var text: String = GameStateMachine.get_game_state_as_string()
	set_text(text)
