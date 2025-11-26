class_name MiniGame extends Control

func _ready() -> void:
	var sa = Globals.get_active_pet_resource()
	var prtin = sa.get_pet_growth_state_as_string()
	
	print(prtin)
