extends Node

var current_happiness: float
var current_hunger:   float
var current_hygiene:  float
var current_game_state: GameState 

## ---[ 1. Finite‑state enum ]---
enum GameState {
	GUI,        # 0
	MAIN,       # 1
	MINI_1,     # 2
	GAME_OVER   # 3
}

const STATE_LABEL := {        
	GameState.GUI:       "GUI",
	GameState.MAIN:      "MAIN",
	GameState.MINI_1:    "MINI_1",
	GameState.GAME_OVER: "GAME_OVER",
}

func _ready() -> void:
	current_game_state = GameState.GUI
	print("Current state:", STATE_LABEL[current_game_state])  ## → "GUI"



func set_current_happiness(value: float) -> void:
	current_happiness = value
	Events.happiness_changed_value(value)   ## fires the broadcast
	print("dsds")

func set_current_hunger(value: float) -> void:
	current_hunger = value
	Events.hunger_changed_value(value)   ## fires the broadcast
	print("hunger")
	
func set_current_hygiene(value: float) -> void:
	current_hygiene = value
	Events.hygiene_changed_value(value)   ## fires the broadcast
	print("hunger")

func set_game_state(NewGameState: GameState) ->void:
	if current_game_state == NewGameState:
		push_error("Already on that state")
		return
	current_game_state = NewGameState
	Events.game_state_changed(current_game_state)
