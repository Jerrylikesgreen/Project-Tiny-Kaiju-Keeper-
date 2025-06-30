## ---------------------------------------------------------------------------
## StateMachine.gd  –  runtime-built table version (no const errors)
## ---------------------------------------------------------------------------
class_name StateMachine
extends Node

enum PetState { IDLE, EVOLVING, DEAD,
				HUNGRY, EATING, POOPING,
				HAPPY, SAD, CHIRPING,
				DIRTY, CLEAN }

@export var start_state: PetState = PetState.IDLE

## Child nodes (wired in the scene) ------------------------------------------
@onready var idle_state:      IdleState      = $IdleState
@onready var hungry_state:    HungryState    = $HungryState
@onready var eating_state:    EatingState    = $EatingState
@onready var dead_state:      DeadState      = $DeadState
@onready var evolving_state:  EvolvingState  = $EvolvingState
## add more as needed
## In your autoload or relevant manager  ------------------------------



func _on_hunger_alert(msg: String, sev: int) -> void:
	print("[Hunger]", msg, "severity:", sev)
	if sev >= 2:                          # 50 % or lower?
		change_state(StateMachine.PetState.HUNGRY)

## Runtime lookup table -------------------------------------------------------
var _state_node: Dictionary            ## PetState → State script

## Book-keeping ---------------------------------------------------------------
var _current_state: State              ## active State script
var _current_enum := -1                ## sentinel (int)

# ---------------------------------------------------------------------------
func _ready() -> void:

	_state_node = {                    ## build once all @onready vars exist
		PetState.IDLE:     idle_state,
		PetState.HUNGRY:   hungry_state,
		PetState.EATING:   eating_state,
		PetState.DEAD:     dead_state,
		PetState.EVOLVING: evolving_state,
		# PetState.POOPING: pooping_state,   # TODO: wire later
	}

	for s in _state_node.values():
		if s:
			s.request_state_change.connect(_on_state_change_request)

	_change_state(start_state)

# ---------------------------------------------------------------------------
func change_state(new_state: PetState) -> void:
	_change_state(new_state)
	print(change_state, "state changed")

func _change_state(new_state: PetState) -> void:
	if new_state == _current_enum:
		push_warning("Already in state %s" % PetState.keys()[new_state])
		return

	if _current_state:
		_current_state.exit()

	if not _state_node.has(new_state):
		push_error("State %s not implemented!"
				   % PetState.keys()[new_state])
		return

	_current_state = _state_node[new_state]
	_current_enum  = new_state
	_current_state.enter()
	print(new_state, "New State")

func _on_state_change_request(next_enum: PetState) -> void:
	_change_state(next_enum)

func _process(delta: float) -> void:
	if _current_state and _current_state.has_method("update"):
		_current_state.update(delta)
