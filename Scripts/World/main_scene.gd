class_name MainSceneS extends Control

@onready var pet_button: PetButton = %PetButton
@onready var pet : PetBody = %PetBody

var intro:bool = false

func  _ready() -> void:
	Events.intro_ended_signal.connect(on_intro_ended_signal)
	pet_button.pressed.connect(_on_pet_pressed)
	if !intro:
		_on_game_start()
	

func on_intro_ended_signal()->void:
	intro = true


func _on_game_start()->void:
	
	print("On game start")
	if Globals.new_game:
		Events.intro()


func _on_pet_pressed()->void:
	
	if intro:
		pet._on_click_input_event()
		print("click")
		Globals.active_pet = pet
		pet_button.queue_free()
		Events.on_pet_growth_state_change(PetBody.PetGrowthState.HATCHLING)
	else:
		return
