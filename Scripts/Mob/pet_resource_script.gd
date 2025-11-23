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


@export var egg_sprite: SpriteFrames
@export var juvinial: SpriteFrames ## Variable holding sprite 
@export var adult: SpriteFrames
@export var hatchling: SpriteFrames
@export var growth_state: PetBody.PetGrowthState
@export var sprite: SpriteFrames
enum EvLine { GODZILA, MOTHRA }
@export var ev_line: EvLine 
