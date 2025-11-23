## globals.gd ─ Autoload Singleton
extends Node




# ────────────────────────────────[ Backing fields ]───────────────────────────────
var _happiness: float = 0.0

var _hunger:   float = 0.0 

var _hygiene:  float = 0.0



var _cookie_count: int = 0
## Current active `GameState`. Do **not** set directly – use `current_game_state`.
## Public properties (set/get)   
# ─────────────────────────────────────┘
var current_happiness : float     : set = set_current_happiness, get = get_current_happiness
var current_hunger    : float     : set = set_current_hunger,    get = get_current_hunger
var current_hygiene   : float     : set = set_current_hygiene,   get = get_current_hygiene

var current_cookie_count: int     : set = set_cookie_count,      get = get_cookie_count

var active_pet: PetBody
var current_pet_growth_state: PetBody.PetGrowthState
var gigazilla_points: float
var mothlyn_points: int
var poop_spawned:bool = false
var feed_count: int = 0
var new_game: bool = true
var pet_age: int
var active_pet_resource: PetResource
var current_sprite_frames: SpriteFrames


func _ready() -> void:
	create_save_folder()


##        Stat setters / getters 
##   (broadcasts fire **after** change)
# ─────────────────────────────[ Lifecycle ]──────────┐
func set_current_happiness(value: float) -> void:
	value = clamp(value, 0.0, 1.0)
	
	if is_equal_approx(value, _happiness):
		return
		
	_happiness = value
	active_pet_resource.happiness = value
	Events.happiness_changed(value)
	

func get_current_happiness() -> float:
	return _happiness

func set_current_hunger(value: float) -> void:
	value = clamp(value, 0.0, 1.0)
	if is_equal_approx(value, _hunger):
		return 
	_hunger = value
	active_pet_resource.hunger = value
	Events.hunger_changed(value)


func get_current_hunger() -> float:
	return _hunger

func set_current_hygiene(value: float) -> void:
	value = clamp(value, 0.0, 1.0)
	if is_equal_approx(value, _hygiene):
		return    

	_hygiene = value
	active_pet_resource.hygiene = value
	Events.hygiene_changed(value)

func get_current_hygiene() -> float:
	return _hygiene
	
func set_pet_growth_state(new_state: PetBody.PetGrowthState)->void:
	current_pet_growth_state = new_state

func get_pet_growth_state()-> PetBody.PetGrowthState:
	return current_pet_growth_state
	
# ──────────────────────────────────────────────────────┘


const SAVE_DIR := "user://saves"
const SAVE_FILE := SAVE_DIR + "/save_game.tres"  # .tres or .res

func create_save_folder() -> void:
	var dir := DirAccess.open("user://")
	if not dir:
		push_error("Failed to open user://")
		return

	# Use recursive in case you later want nested structure
	if not dir.dir_exists("saves"):
		var err := dir.make_dir("saves")
		if err != OK:
			push_error("Failed to create saves folder: %s" % err)
			return
		print("Save folder created.")
	else:
		print("Save folder already exists.")


func save_game() -> void:
	# Ensure folder exists
	create_save_folder()

	# Prepare SaveData (must be a Resource)
	var data := SaveData.new()
	data.happiness = _happiness
	data.hunger = _hunger
	data.hygiene = _hygiene
	data.feed_count = feed_count
	data.poop_spawned = poop_spawned
	data.gigazilla_points = gigazilla_points
	data.mothlyn_points = mothlyn_points

	if active_pet:
		data.age = active_pet.pet_resource.age if active_pet.pet_resource else 0
		# Prefer saving resource path or an identifier instead of raw object
		# e.g. data.active_pet_resource_path = active_pet.pet_resource.resource_path
		data.active_pet_resource = active_pet.pet_resource

	# Save as a Resource (.tres)
	var save_result := ResourceSaver.save(data, SAVE_FILE)
	if save_result == OK:
		print("Game saved to %s" % SAVE_FILE)
	else:
		push_error("Save failed (error %s) while saving to %s" % [str(save_result), SAVE_FILE])


func load_game() -> void:
	if not FileAccess.file_exists(SAVE_FILE):
		print("No save file found at %s" % SAVE_FILE)
		return

	var loaded := ResourceLoader.load(SAVE_FILE)
	if not loaded:
		push_error("Failed to load resource at %s" % SAVE_FILE)
		return

	if loaded is SaveData:
		# Apply loaded values to globals
		_happiness = loaded.happiness
		_hunger = loaded.hunger
		_hygiene = loaded.hygiene
		feed_count = loaded.feed_count
		poop_spawned = loaded.poop_spawned
		gigazilla_points = loaded.gigazilla_points
		mothlyn_points = loaded.mothlyn_points

		if active_pet:
			# Be careful with private vars (leading underscore)
			active_pet.age = loaded.age
			active_pet._new_game = loaded.is_new_game 

			# Ensure set_stage is awaitable — otherwise call directly
			if active_pet.base_body_sprite.has_method("set_stage"):
				var res = active_pet.base_body_sprite.set_stage(loaded.evolution_stage)
				# Only await if the method returns a GDScriptFunctionState (async)
				if typeof(res) == TYPE_OBJECT:
					await res

		# Emit signals
		Events.happiness_changed(_happiness)
		Events.hunger_changed(_hunger)
		Events.hygiene_changed(_hygiene)

		print("Game loaded from %s" % SAVE_FILE)
	else:
		push_error("Invalid save data at %s" % SAVE_FILE)


func set_cookie_count(value: int) -> void:
	value = max(value, 0)
	if is_equal_approx(value, _cookie_count):
		return
	_cookie_count = value

func get_cookie_count() -> int:
	return _cookie_count
