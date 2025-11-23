class_name MainSceneS extends Control

@onready var pet_button: PetButton = %PetButton
@onready var pet : PetBody = %PetBody

var intro:bool = false

func  _ready() -> void:
	pet_button.pressed.connect(_on_pet_pressed)
	if !intro:
		_on_game_start()
	



func _on_game_start()->void:
	
	print("On game start")
	if Globals.new_game:
		Events.display_player_message("Welcome, to Kiaju Keeper!")
		Events.display_player_message("Play with your kaiju to find yummy treats!")
		Events.display_player_message("Click on your egg to help it hatch!")
		intro = true
		Events.game_start()

func _on_pet_pressed()->void:
	if intro:
		pet._on_click_input_event()
		print("click")
		pet_button.queue_free()
		Events.on_pet_growth_state_change(PetBody.PetGrowthState.HATCHLING)
	else:
		return
