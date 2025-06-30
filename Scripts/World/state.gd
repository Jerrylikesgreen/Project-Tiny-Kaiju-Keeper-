
class_name State
extends Node

signal request_state_change(next_state: StateMachine.PetState)

const FALLBACK_STATE: String = "IDLE" ## used to set Idle as Default.     

func update(_dt: float): pass


func _ready() -> void:
	Events.happiness_changed.connect(_on_happiness_changed)
	Events.hunger_changed.connect(_on_hunger_changed)
	Events.hygiene_changed.connect(_on_hygiene_changed)

func _on_happiness_changed(label_text:String, value: float) -> void:
	pass
func _on_hunger_changed(label_text:String, value: float) -> void:
	pass
func _on_hygiene_changed(label_text:String, value: float) -> void:
	pass

func enter() -> void:
	Events.happiness_changed.connect(_on_happiness_changed)
	Events.hunger_changed.connect(_on_hunger_changed)
	Events.hygiene_changed.connect(_on_hygiene_changed)

func exit() -> void:
	if Events.happiness_changed.is_connected(_on_happiness_changed):
		Events.happiness_changed.disconnect(_on_happiness_changed)
	if Events.hunger_changed.is_connected(_on_hunger_changed):
		Events.hunger_changed.disconnect(_on_hunger_changed)
	if Events.hygiene_changed.is_connected(_on_hygiene_changed):
		Events.hygiene_changed.disconnect(_on_hygiene_changed)
