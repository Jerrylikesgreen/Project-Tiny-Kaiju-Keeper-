class_name BaseBody extends CharacterBody2D
## Base body class that all Movable Enteties : Mobs Will inharit. 

@export var growth_speed: int = 1 ## Variable determining the rate in which pet grows. 
@export var pet_resource: PetResource      ## happiness, hunger, hygiene, sprite

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
