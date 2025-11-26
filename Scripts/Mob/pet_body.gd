class_name PetBody extends CharacterBody2D
## Base body class that all Movable Enteties : Mobs Will inharit. 


@export var growth_speed: int = 1 ## Variable determining the rate in which pet grows. 
@export var pet_resource: PetResource      ## happiness[1.0]:float, hunger[1.0]:float, hygiene[1.0]:float, sprite
@export var _can_get_hungry:bool = false
@export var _can_get_happy:bool = false
@export var _can_get_hygiene:bool = false
@export var _can_age:bool = false
@onready var pet_interaction: Button = %PetInteraction
@onready var hunger_tick: Timer = %HungerTick
@onready var happy_tick: Timer = %HappyTick
@onready var hygiene_tick: Timer = %HygieneTick
@onready var sfx: SFX = %SFX
@onready var ev_sfx: AudioStreamPlayer = $EvSFX
@onready var body_sprite: BaseBodySprite = %BaseBodySprite
@onready var animation: AnimationPlayer = %AnimationPlayerpet
@onready var label: Label = %Label
@onready var mood_display: MoodDisplay = %MoodDisplay



const StatusEnum = preload("uid://bsknb2ab5somj")


const LABLESTATES = {
	PetResource.PetGrowthState.EGG : "Egg",
	PetResource.PetGrowthState.HATCHLING : "Hatchling",
	PetResource.PetGrowthState.JUVINIAL: "Juvinile", 
	PetResource.PetGrowthState.ADULT: "Adult"
}


func _process(delta: float) -> void:
	label.set_text(LABLESTATES[pet_resource.pet_growth_state])

func _ready() -> void:
	pet_interaction.pressed.connect(_check_mood)
	Events.game_start_signal.connect(_on_game_start)
	Events.mini_game_started_signal.connect(_on_mini_game_start)
	Events.evolve_signal.connect(_evolution)
	pet_resource.pet_growth_state = Globals.get_pet_growth_state()
	Events.game_state.connect(_on_game_state_changed)
	if GameStateMachine.get_prior_game_state() == GameStateMachine.GameState.MINI:
		_toogle_ticks(true)



func _check_mood()->void:
	var happy = Globals.get_current_happiness()
	var hunger = Globals.get_current_hunger()
	var hygine = Globals.get_current_hygiene()
	var status := get_overall_status_enum(happy, hunger, hygine)
	
	match status:
		StatusEnum.Status.POOR:
			print("Poor")
			mood_display.mood(StatusEnum.Status.POOR)
		StatusEnum.Status.MID:
			print("Mid")
			mood_display.mood(StatusEnum.Status.MID)
		StatusEnum.Status.GOOD:
			print("Good")
			mood_display.mood(StatusEnum.Status.GOOD)
		StatusEnum.Status.EXCELLENT:
			print("Excellentdd")
			mood_display.mood(StatusEnum.Status.EXCELLENT)
		_:
			print("Unknown")
			mood_display.mood(StatusEnum.Status.UNKNOWN)





func get_overall_status_enum(happy: float, hunger: float, hygiene: float) -> StatusEnum.Status:
	var total := happy + hunger + hygiene
	var count := 3.0  # number of stats used

	if total <= 0.0:
		return StatusEnum.Status.UNKNOWN

	var result := total / count  # average value between 0 and 1

	if result < 0.25:
		return StatusEnum.Status.POOR
	elif result < 0.5:
		return StatusEnum.Status.MID
	elif result < 0.75:
		return StatusEnum.Status.GOOD
	else:
		return StatusEnum.Status.EXCELLENT




func _on_game_state_changed(state: GameStateMachine.GameState)->void:
	print("state change signal received. ")

func _toogle_ticks(v: bool)->void:
	print("toogle tick")
	_can_get_hygiene = v
	_can_get_happy  = v
	_can_get_hungry = v
	_can_age        = v


func _set_growth_state(new_growth_state: PetResource.PetGrowthState):
	pet_resource.pet_growth_state = new_growth_state
	Events.on_pet_growth_state_change(new_growth_state)


func update_globals_from_pet(pet: PetResource) -> void:
	Globals.set_active_pet_resource( pet )
	Globals.set_current_happiness(pet.happiness)
	Globals.set_current_hunger(pet.hunger)
	Globals.set_current_hygiene(pet.hygiene)
	Globals.set_pet_growth_state(pet.pet_growth_state)


func start_hunger_tick()->void:
	if _can_get_hungry == true :
		hunger_tick.start(1.0)

func start_happy_tick()->void:
	if _can_get_happy == true :
		happy_tick.start(1.0)

func start_hygiene_tick()->void:
	print("Strat hygine")
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
			_evolution(pet_resource.PetGrowthState.JUVINIAL)
		if pet_resource.age == 100:
			_evolution(pet_resource.PetGrowthState.ADULT)
		Globals.pet_age = pet_resource.age


func _evolution(state)->void:
	match state:
		pet_resource.PetGrowthState.HATCHLING:
			pet_resource.pet_growth_state = state
			update_globals_from_pet(pet_resource)
			
		pet_resource.PetGrowthState.JUVINIAL:
			_check_ev_line()
			pet_resource.pet_growth_state = state
			update_globals_from_pet(pet_resource)
			
		pet_resource.PetGrowthState.ADULT:
			pet_resource.pet_growth_state = state
			update_globals_from_pet(pet_resource)
	

func _check_ev_line():
	if Globals.gigazilla_points > Globals.mothlyn_points:
		pet_resource.ev_line = pet_resource.EvLine.GODZILA
	else:
		pet_resource.ev_line = pet_resource.EvLine.MOTHRA


func _on_game_start():
	if Globals.new_game:
		Globals._active_pet_resource = pet_resource
		Globals.set_current_happiness(1.0)
		Globals.set_current_hygiene(1.0)
		Globals.set_current_hunger(1.0)


	
func _on_mini_game_start():
	_toogle_ticks(false)
	print("_on_mini_game_start")

func _on_click_input_event() -> void:
	_toogle_ticks(true)
	animation.play("Clicked")
	print("click")
