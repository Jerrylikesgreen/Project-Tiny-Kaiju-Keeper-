class_name BaseBody extends CharacterBody2D
## Base body class that all Movable Enteties : Mobs Will inharit. 

@export var age:int = 0
@export var growth_speed: int = 1 ## Variable determining the rate in which pet grows. 
@export var pet_resource: PetResource      ## happiness[1.0]:float, hunger[1.0]:float, hygiene[1.0]:float, sprite
@export var hunger_rate: int = 1 
@export var happy_rate: int = 1 
@export var hygiene_rate: int = 1 
@export var _can_get_hungry:bool = false
@export var _can_get_happy:bool = false
@export var _can_get_hygiene:bool = false
@export var _can_age:bool = false
@onready var hunger_tick: Timer = %HungerTick
@onready var happy_tick: Timer = %HappyTick
@onready var hygiene_tick: Timer = %HygieneTick
@onready var sfx: SFX = %SFX
@export var _is_godzilla = false


@onready var ev_sfx: AudioStreamPlayer = $EvSFX
@onready var ev_visual_effect: Node2D = $"BaseBodySprite/Ev Visual Effect"
@onready var base_body_sprite: BaseBodySprite = %BaseBodySprite

var _new_game:bool = true

func _ready() -> void:
	#update_globals_from_pet(pet_resource)
	Events.poop.connect(_on_poop_call)
	Events.game_start.connect(_on_game_start)
	Events.mini_game_ended.connect(_on_mini_game_return)
	Events.mini_game_started.connect(_on_mini_game_start)

var current_stage: BaseBodySprite.Stage

func set_stage(new_stage: BaseBodySprite.Stage):
	current_stage = new_stage
	Globals.current_pet_stage = new_stage


func update_globals_from_pet(pet: PetResource) -> void:
	if not Globals.resource_exists("user://save_game.save"):
		# brandânew profile â push defaults once
		Globals.set_current_happiness(pet.happiness)
		Globals.set_current_hunger(pet.hunger)
		Globals.set_current_hygiene(pet.hygiene)

		if has_node("Sprite2D") and pet.sprite != null:
			$"Sprite2D".texture = pet.sprite


func start_hunger_tick()->void:
	if _can_get_hungry == true :
		hunger_tick.start(1.0)

func start_happy_tick()->void:
	if _can_get_happy == true :
		happy_tick.start(1.0)

func start_hygiene_tick()->void:
	if _can_get_hygiene == true :
		hygiene_tick.start(1.0)


func _on_hunger_tick_timeout() -> void:
	if !_can_get_hungry:
		return
	var rate = 0.01 * hunger_rate
	var value = Globals.current_hunger - rate
	Globals.set_current_hunger(value)


func _on_happy_tick_timeout() -> void:
	if !_can_get_happy:
		return
	var rate = 0.01 * happy_rate
	var value = Globals.current_happiness - rate
	Globals.set_current_happiness(value)


func _on_hygiene_tick_timeout() -> void:
	if !_can_get_hygiene:
		return
	var rate = 0.01 * hygiene_rate
	var value = Globals.current_hygiene - rate
	Globals.set_current_hygiene(value)



func _on_chipring_state_chirp() -> void:
	sfx.play_track(sfx.Track.CHIRP)
	pass # Replace with function body.


func _on_growth_tick_timeout() -> void:
	if _can_age == false:
		return
	else:
		age = age + 1 * growth_speed
		if age == 10:
			_on_evolution(1)
		if age == 30:
			_on_evolution(2)
		if age == 60:
			_on_evolution(3)
		Globals.pet_age = age




func _on_evolution(stage:int)->void:
	ev_sfx.play()
	print("Evolution SFX trigger")
	match stage:
		1:
			await base_body_sprite.set_stage(base_body_sprite.Stage.HATCHLING)
			Events.emit_signal("evolve", 2)
			
		2:
			_check_ev_line()
			if !_is_godzilla:
				base_body_sprite.set_stage(base_body_sprite.Stage.JUV_MOTH)
				print(_is_godzilla, "mothy")
			else:
				base_body_sprite.set_stage(base_body_sprite.Stage.JUV_GIGA)
				print(_is_godzilla, "gigi")
			Events.emit_signal("evolve", 3)
		3:
			if !_is_godzilla:
				base_body_sprite.set_stage(base_body_sprite.Stage.ADULT_MOTH)
			else:
				base_body_sprite.set_stage(base_body_sprite.Stage.ADULT_GIGA)
			Events.emit_signal("evolve", 4)
	ev_visual_effect.play()

func _check_ev_line():
	if Globals.gigazilla_points > Globals.mothlyn_points:
		_is_godzilla = true


func _on_poop_call(v:bool):
	if v == true:
		hygiene_rate = 2
	else:
		hygiene_rate = 1
	pass

func _on_game_start():
	if Globals.new_game:
		Globals.set_current_happiness(1.0)
		Globals.set_current_hygiene(1.0)
		Globals.set_current_hunger(1.0)
		Globals.new_game = false
		_can_age = true
		_can_get_happy = true
		_can_get_hygiene = true
		_can_get_hungry = true


func _on_mini_game_return():
	var s = str(Globals.current_pet_stage)
	base_body_sprite.set_stage(Globals.current_pet_stage)
	age = Globals.pet_age
	_can_age = true
	_can_get_happy = true
	_can_get_hygiene = true
	_can_get_hungry = true
	
func _on_mini_game_start():
	_can_age = false
	_can_get_happy = false
	_can_get_hygiene = false
	_can_get_hungry = false
