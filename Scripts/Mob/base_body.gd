class_name BaseBody extends CharacterBody2D
## Base body class that all Movable Enteties : Mobs Will inharit. 

@export var growth_speed: int = 1 ## Variable determining the rate in which pet grows. 
@export var pet_resource: PetResource      ## happiness[1.0]:float, hunger[1.0]:float, hygiene[1.0]:float, sprite
@export var hunger_rate: int = 1 
@export var _can_get_hungry:bool = true
@onready var hunger_tick: Timer = %HungerTick



func _ready() -> void:
	call_deferred("_push_happiness")     ## ensures broadcast happens last

func _push_happiness() -> void: ## private function that sends happiness to Globals. 
	update_globals_from_pet(pet_resource)
	print(pet_resource.happiness)


func update_globals_from_pet(pet: PetResource) -> void: ## Sets up fucntions and variabnles to distribute resource across 
														## all enteties that require this information;
	if pet == null: ## Checks is the resource being passed through is assigned to the receiving node. 
		push_warning("PetResource not assigned on %s" % name)
		return## If not it iognores the call. 

	Globals.set_current_happiness(pet.happiness)
	Globals.set_current_hygiene(pet.hygiene)
	Globals.set_current_hunger(pet.hunger)
	print(pet.happiness, pet.hunger, pet.hygiene )

	if has_node("Sprite2D") and pet.sprite != null:
		$"Sprite2D".texture = pet.sprite


func start_hunger_tick()->void:
	if _can_get_hungry == true :
		hunger_tick.start(1.0)
	


func _on_hunger_tick_timeout() -> void:
	var value = Globals.current_hunger 
	Globals.set_current_hunger(value)
