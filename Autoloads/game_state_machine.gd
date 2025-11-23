## GameState Autoload. 
extends Node


# ────────────────────────────────[ Game-state enum ]───────────────────────────────
enum GameState { GUI, MAIN, MINI, GAME_OVER, TITLE } ## Game‑state enum & label lookup
var _game_state: GameState = GameState.TITLE 


const STATE_LABEL := {
	GameState.GUI:        "GUI",
	GameState.MAIN:       "MAIN",
	GameState.MINI:     "MINI",
	GameState.GAME_OVER:  "GAME_OVER",
	GameState.TITLE:      "TITLE",
}

var current_game_state: GameState : set = set_game_state,        get = get_game_state
var _prior_game_state: GameState


func _ready() -> void:
	print("Current state:", STATE_LABEL[_game_state])


## Game‑state setter / getter 
func set_game_state(new_state: GameState) -> void:
	if _game_state == new_state:
		push_error("Already in that state")
		return
	_prior_game_state = _game_state
	_game_state = new_state
	
	

func get_game_state() -> GameState:
	return _game_state

func get_game_state_as_string() -> String:
	var output: String = STATE_LABEL[_game_state]
	return output

func get_prior_game_state() -> GameState:
	return _prior_game_state
