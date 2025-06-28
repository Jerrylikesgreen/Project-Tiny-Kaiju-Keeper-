extends Node

var current_happiness: float
var current_hunger:   float
var current_hygiene:  float

func set_current_happiness(value: float) -> void:
	current_happiness = value
	Events.happiness_changed_value(value)   # fires the broadcast
	print("dsds")

func set_current_hunger(value: float) -> void:
	current_hunger = value
	Events.hunger_changed_value(value)   # fires the broadcast
	print("hunger")
	
func set_current_hygiene(value: float) -> void:
	current_hygiene = value
	Events.hygiene_changed_value(value)   # fires the broadcast
	print("hunger")
