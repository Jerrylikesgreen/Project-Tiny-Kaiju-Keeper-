class_name PetResource extends Resource
## Base pet resource all pets will inharent. Will be used to hold default data and values.
## Will al.so serve as a basis for the save/load system. 

@export var happiness: float = 1.0  ## Variable holding happiness value,  0 = empty, 1 = full. 
@export var hunger: float = 1.0  ## Variable holding hunger value, 0 = empty, 1 = full. 
@export var hygiene: float = 1.0  ## Variable holding hygine value, 0 = empty, 1 = full. 
@export var age:int = 0
@export var hunger_rate: int = 1 
@export var happy_rate: int = 1 
@export var hygiene_rate: int = 1 


@export var egg_sprite: CompressedTexture2D
@export var juvinial: CompressedTexture2D ## Variable holding sprite 
@export var adult: CompressedTexture2D
@export var hatchling: CompressedTexture2D


enum EvLine { GODZILA, MOTHRA }
@export var ev_line: EvLine 
