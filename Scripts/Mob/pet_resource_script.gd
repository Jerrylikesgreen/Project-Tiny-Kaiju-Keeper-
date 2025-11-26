class_name PetResource extends Resource
## Base pet resource all pets will inharent. Will be used to hold default data and values.
## Will al.so serve as a basis for the save/load system. 

const ADULT_GIGAZILLA = preload("res://Resources/Sprite/adult_gigazilla.tres")
const ADULT_MOTHLYN = preload("res://Resources/Sprite/adult_mothlyn.tres")
const EGG_1 = preload("res://Resources/Sprite/egg.tres")
const EGG_2 = preload("res://Resources/Sprite/egg_2.tres")
const HATCHLING = preload("res://Resources/Sprite/hatchling.tres")
const JUVENILE_GIGAZILLA = preload("res://Resources/Sprite/juvinial_gigazilla.tres")
const JUVENILE_MOTHLYN = preload("res://Resources/Sprite/juvinial_mothlyn.tres")


@export var happiness: float = 1.0  ## Variable holding happiness value,  0 = empty, 1 = full. 
@export var hunger: float = 1.0  ## Variable holding hunger value, 0 = empty, 1 = full. 
@export var hygiene: float = 1.0  ## Variable holding hygine value, 0 = empty, 1 = full. 
@export var age:int = 0
@export var hunger_rate: int = 1 
@export var happy_rate: int = 1 
@export var hygiene_rate: int = 1 


@export var sprite: SpriteFrames
enum EvLine { GODZILA, MOTHRA }
@export var ev_line: EvLine 

enum PetGrowthState { EGG, HATCHLING, JUVINIAL, ADULT }
@export var pet_growth_state: PetGrowthState = PetGrowthState.EGG

const PETGROWTHSTATE = {
	PetGrowthState.EGG: "Egg",
	PetGrowthState.HATCHLING: "Hatchling",
	PetGrowthState.JUVINIAL: "Juvinile",
	PetGrowthState.ADULT: "Adult"
}

func get_pet_growth_state_as_string()->String:
	return PETGROWTHSTATE[pet_growth_state]

func get_sprite() ->SpriteFrames:
	var _sprite: SpriteFrames
	
	match pet_growth_state:
		PetGrowthState.EGG:
			_sprite = EGG_2
		PetGrowthState.HATCHLING:
			_sprite = HATCHLING
		PetGrowthState.JUVINIAL:
			match ev_line:
				EvLine.GODZILA:
					_sprite = JUVENILE_GIGAZILLA
				EvLine.MOTHRA:
					_sprite = JUVENILE_MOTHLYN
		PetGrowthState.ADULT:
			match ev_line:
				EvLine.GODZILA:
					_sprite = ADULT_GIGAZILLA
				EvLine.MOTHRA:
					_sprite = ADULT_MOTHLYN
	if !_sprite:
		_sprite = EGG_1
	return _sprite
