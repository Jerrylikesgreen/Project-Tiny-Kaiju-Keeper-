class_name BaseBody extends CharacterBody2D
## Base body class that all Movable Enteties : Mobs Will inharit. 

@export var age:int = 0
@export var growth_speed: int = 1 ## Variable determining the rate in which pet grows. 
@export var pet_resource: PetResource      ## happiness[1.0]:float, hunger[1.0]:float, hygiene[1.0]:float, sprite
@export var hunger_rate: int = 1 
@export var happy_rate: int = 1 
@export var hygiene_rate: int = 1 
@export var _can_get_hungry:bool = true
@export var _can_get_happy:bool = true
@export var _can_get_hygiene:bool = true
@onready var hunger_tick: Timer = %HungerTick
@onready var happy_tick: Timer = %HappyTick
@onready var hygiene_tick: Timer = %HygieneTick
@onready var sfx: SFX = %SFX
@export var _is_godzilla = false
@onready var base_body_sprite: BaseBodySprite = $BaseBodySprite
@onready var ev_sfx: AudioStreamPlayer = $EvSFX
@onready var ev_visual_effect: Node2D = $"BaseBodySprite/Ev Visual Effect"



func _ready() -> void:
	update_globals_from_pet(pet_resource)


func update_globals_from_pet(pet: PetResource) -> void: ## Sets up fucntions and variabnles to distribute resource across 
														## all enteties that require this information;
	if pet == null: ## Checks is the resource being passed through is assigned to the receiving node. 
		push_warning("PetResource not assigned on %s" % name)
		return## If not it iognores the call. 

	Globals.set_current_happiness(pet.happiness)
	Globals.set_current_hygiene(pet.hygiene)
	Globals.set_current_hunger(pet.hunger)

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
	var rate = 0.01 * hunger_rate
	var value = Globals.current_hunger - rate
	Globals.set_current_hunger(value)
	push_warning("_on_hunger_tick_timeout")




func _on_happy_tick_timeout() -> void:
	var rate = 0.01 * happy_rate
	var value = Globals.current_happiness - rate
	Globals.set_current_happiness(value)
	push_warning("_on_happy_tick_timeout")

func _on_hygiene_tick_timeout() -> void:
	var rate = 0.01 * hygiene_rate
	var value = Globals.current_hygiene - rate
	Globals.set_current_hygiene(value)
	push_warning("_on_hygiene_tick_timeout")


func _on_chipring_state_chirp() -> void:
	sfx.play_track(sfx.Track.CHIRP)
	pass # Replace with function body.


func _on_growth_tick_timeout() -> void:
	age = age + 1 * growth_speed
	if age == 10:
		_on_evolution(1)
	if age == 30:
		_on_evolution(2)
	if age == 60:
		_on_evolution(3)
	pass # Replace with function body.
	
func _on_evolution(stage:int)->void:
	ev_sfx.play()
	print("Evolution SFX trigger")
	match stage:
		1:
			base_body_sprite.set_stage(base_body_sprite.Stage.HATCHLING)
		2:
			if !_is_godzilla:
				base_body_sprite.set_stage(base_body_sprite.Stage.JUV_MOTH)
				print(_is_godzilla, "mothy")
			else:
				base_body_sprite.set_stage(base_body_sprite.Stage.JUV_GIGA)
				print(_is_godzilla, "gigi")
		3:
			if !_is_godzilla:
				base_body_sprite.set_stage(base_body_sprite.Stage.ADULT_MOTH)
			else:
				base_body_sprite.set_stage(base_body_sprite.Stage.ADULT_GIGA)
	ev_visual_effect.play()
