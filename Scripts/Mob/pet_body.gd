class_name PetBody extends CharacterBody2D
## Base body class that all Movable Enteties : Mobs Will inharit. 


@export var growth_speed: int = 1 ## Variable determining the rate in which pet grows. 
@export var pet_resource: PetResource      ## happiness[1.0]:float, hunger[1.0]:float, hygiene[1.0]:float, sprite

@export var _can_get_hungry:bool = false
@export var _can_get_happy:bool = false
@export var _can_get_hygiene:bool = false
@export var _can_age:bool = false

@onready var hunger_tick: Timer = %HungerTick
@onready var happy_tick: Timer = %HappyTick
@onready var hygiene_tick: Timer = %HygieneTick
@onready var sfx: SFX = %SFX
@onready var ev_sfx: AudioStreamPlayer = $EvSFX
@onready var base_body_sprite: BaseBodySprite = %BaseBodySprite
@onready var animation: AnimationPlayer = %AnimationPlayerpet

enum PetGrowthState { EGG, HATCHLING, JUVINIAL, ADULT }
var pet_growth_state: PetGrowthState = PetGrowthState.EGG

func _ready() -> void:
	Events.game_start_signal.connect(_on_game_start)
	Events.mini_game_ended.connect(_on_mini_game_return)
	Events.mini_game_started.connect(_on_mini_game_start)
	Events.evolve_signal.connect(_evolution)
	update_globals_from_pet(pet_resource)



func _set_growth_state(new_growth_state: PetGrowthState):
	pet_growth_state = new_growth_state
	Events.on_pet_growth_state_change(new_growth_state)


func update_globals_from_pet(pet: PetResource) -> void:
	Globals.set_current_happiness(pet.happiness)
	Globals.set_current_hunger(pet.hunger)
	Globals.set_current_hygiene(pet.hygiene)
	Globals.active_pet_frames = base_body_sprite.


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
	var rate = 0.01 * pet_resource.hunger_rate
	var value = Globals.current_hunger - rate
	Globals.set_current_hunger(value)


func _on_happy_tick_timeout() -> void:
	if !_can_get_happy:
		return
	var rate = 0.01 * pet_resource.happy_rate
	var value = Globals.current_happiness - rate
	Globals.set_current_happiness(value)


func _on_hygiene_tick_timeout() -> void:
	if !_can_get_hygiene:
		return
	var rate = 0.01 * pet_resource.hygiene_rate
	var value = Globals.current_hygiene - rate
	Globals.set_current_hygiene(value)



func _on_chipring_state_chirp() -> void:
	sfx.play_track(sfx.Track.CHIRP)
	pass # Replace with function body.


func _on_growth_tick_timeout() -> void:
	if _can_age == false:
		return
	else:
		pet_resource.age = pet_resource.age + 1 * growth_speed
		if pet_resource.age == 50:
			_evolution(PetGrowthState.JUVINIAL)
		if pet_resource.age == 100:
			_evolution(PetGrowthState.ADULT)
		Globals.pet_age = pet_resource.age


func _evolution(state:PetGrowthState)->void:
	match state:
		PetGrowthState.HATCHLING:
			pet_growth_state = state
			
		PetGrowthState.JUVINIAL:
			_check_ev_line()
			pet_growth_state = state
			
		PetGrowthState.ADULT:
			pet_growth_state = state
	

func _check_ev_line():
	if Globals.gigazilla_points > Globals.mothlyn_points:
		pet_resource.ev_line = pet_resource.EvLine.GODZILA
	else:
		pet_resource.ev_line = pet_resource.EvLine.MOTHRA


func _on_poop_call(v:bool):
	if v == true:
		pet_resource.hygiene_rate = 2
	else:
		pet_resource.hygiene_rate = 1
	pass

func _on_game_start():
	if Globals.new_game:
		Globals.set_current_happiness(1.0)
		Globals.set_current_hygiene(1.0)
		Globals.set_current_hunger(1.0)



func _on_mini_game_return():
	base_body_sprite.set_stage(Globals.current_pet_stage)
	pet_resource.age = Globals.pet_age
	_can_age = true
	_can_get_happy = true
	_can_get_hygiene = true
	_can_get_hungry = true
	
func _on_mini_game_start():
	_can_age = false
	_can_get_happy = false
	_can_get_hygiene = false
	_can_get_hungry = false


func _on_click_input_event() -> void:
	_can_age = true
	_can_get_happy = true
	_can_get_hygiene = true
	_can_get_hungry = true
	animation.play("Clicked")
	print("click")
