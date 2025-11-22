## globals.gd ─ Autoload Singleton
extends Node



# ────────────────────────────────[ Game-state enum ]───────────────────────────────
enum GameState { GUI, MAIN, MINI_1, GAME_OVER, TITLE } ## Game‑state enum & label lookup
var _game_state: GameState = GameState.TITLE 

## High-level scenes / modes the game can be in.
const STATE_LABEL := {
	GameState.GUI:        "GUI",
	GameState.MAIN:       "MAIN",
	GameState.MINI_1:     "MINI_1",
	GameState.GAME_OVER:  "GAME_OVER",
	GameState.TITLE:      "TITLE",
}
## Human-readable labels for each `GameState` value (handy for debug prints).


# ────────────────────────────────[ Backing fields ]───────────────────────────────
var _happiness: float = 0.0

var _hunger:   float = 0.0 

var _hygiene:  float = 0.0



var _cookie_count: int = 0
## Current active `GameState`. Do **not** set directly – use `current_game_state`.
## Public properties (set/get)   
# ─────────────────────────────────────┘
var current_happiness : float     : set = set_current_happiness, get = get_current_happiness
## Pet’s happiness level (0‒100).
var current_hunger    : float     : set = set_current_hunger,    get = get_current_hunger
## Pet’s hunger level (0‒100).  Higher = hungrier.
var current_hygiene   : float     : set = set_current_hygiene,   get = get_current_hygiene
## Pet’s hygiene level (0‒100).
var current_game_state: GameState : set = set_game_state,        get = get_game_state
## Active macro-state (GUI, MAIN play, etc.).
var current_cookie_count: int     : set = set_cookie_count,      get = get_cookie_count


var current_pet_stage: BaseBodySprite.Stage
var gigazilla_points: float
var mothlyn_points: int
var poop_spawned:bool = false
var feed_count: int = 0
var _is_godzilla: bool 
var new_game: bool = true
var pet_age: int



## At ready
func _ready() -> void:
	print("Current state:", STATE_LABEL[_game_state])

##        Stat setters / getters 
##   (broadcasts fire **after** change)
# ─────────────────────────────[ Lifecycle ]──────────┐
func set_current_happiness(value: float) -> void:
	value = clamp(value, 0.0, 1.0)
	
	if is_equal_approx(value, _happiness):
		return
		
	_happiness = value
	Events.happiness_changed(value)
	

func get_current_happiness() -> float:
	return _happiness

func set_current_hunger(value: float) -> void:
	value = clamp(value, 0.0, 1.0)
	if is_equal_approx(value, _hunger):
		return 
	_hunger = value
	Events.hunger_changed(value)


func get_current_hunger() -> float:
	return _hunger

func set_current_hygiene(value: float) -> void:
	value = clamp(value, 0.0, 1.0)
	if is_equal_approx(value, _hygiene):
		return    

	_hygiene = value
	Events.hygiene_changed(value)

func get_current_hygiene() -> float:
	return _hygiene
# ──────────────────────────────────────────────────────┘

## Game‑state setter / getter 
func set_game_state(new_state: GameState) -> void:
	if _game_state == new_state:
		push_error("Already in that state")
		return
	
	_game_state = new_state
	

func get_game_state() -> GameState:
	return _game_state


	
func save_game():
	var data := SaveData.new()
	data.happiness = _happiness
	data.hunger = _hunger
	data.hygiene = _hygiene
	data.feed_count = feed_count
	data.poop_spawned = poop_spawned
	data.gigazilla_points = gigazilla_points
	data.mothlyn_points = mothlyn_points
	data.is_godzilla = _is_godzilla
	

	var pet = get_node_or_null("/root/Main/MainDisplayLayer/MainDisplayContainer/WorldManager/PetLayer/BaseBody")  # Adjust to your actual path
	if pet:
		data.age = pet.age
		data.evolution_stage = pet.base_body_sprite.current_stage
		data.is_new_game = pet._new_game

	var save_result = ResourceSaver.save(data, "user://save_game.save")
	print("Game saved." if save_result == OK else "Save failed!")


func load_game():
	var save_path = "user://save_game.save"
	if not ResourceLoader.exists(save_path):
		print("No save file found.")
		return
	
	var loaded = ResourceLoader.load(save_path)
	if loaded is SaveData:
		# Apply loaded values to globals
		_happiness = loaded.happiness
		_hunger = loaded.hunger
		_hygiene = loaded.hygiene
		feed_count = loaded.feed_count
		poop_spawned = loaded.poop_spawned
		gigazilla_points = loaded.gigazilla_points
		mothlyn_points = loaded.mothlyn_points
	

		var pet = get_node_or_null("/root/Main/MainDisplayLayer/MainDisplayContainer/WorldManager/PetLayer/BaseBody")
		if pet:
			pet.age = loaded.age
			pet._new_game = loaded.is_new_game
			await pet.base_body_sprite.set_stage(loaded.evolution_stage)

		# Emit signals
		Events.happiness_changed( _happiness)
		Events.hunger_changed(_hunger)
		Events.hygiene_changed(_hygiene)

		print("Game loaded.")
	else:
		print("Invalid save data.")
		


func set_cookie_count(value: int) -> void:
	value = max(value, 0)
	if is_equal_approx(value, _cookie_count):
		return
	_cookie_count = value

func get_cookie_count() -> int:
	return _cookie_count
