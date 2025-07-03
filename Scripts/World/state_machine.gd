class_name StateMachine extends Node



@onready var idle_state: IdleState = %IdleState
@onready var chipring_state: ChirpingState = %ChipringState


@export_enum("IDLE", "CHIRPING", "EATING", "CLEANING") var PET_STATE = 0


var event: String
var value: float

func _ready() -> void:
	
	Events.pet_event_signal.connect(_on_pet_event)

func _change_state(pet_state: int)-> void:
	if PET_STATE == pet_state:
		push_warning("Duplicate State")
		return
	if PET_STATE == 0:
		idle_state.run_idle_logic()

func _on_pet_event(incomming_event: String, value: float):
	if incomming_event == "Happy":
		chipring_state.run_chirping_state()


func _on_chipring_state_chirp_state_ended() -> void:
	if PET_STATE == 1:
		push_error("State was still set to Chirping after state ended signal was fired.")
	_change_state(0)
	pass # Replace with function body.
