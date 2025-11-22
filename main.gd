class_name MainScene extends Control

@onready var pet: PetButton = %Pet
@onready var base_body: BaseBody = %BaseBody

var intro:bool = false

func  _ready() -> void:
	Events.game_start.connect(_on_game_start)
	pet.pressed.connect(_on_pet_pressed)



func _on_game_start()->void:
	print("On game start")
	if !Globals.new_game:
		Events.display_player_message("Welcome, this here is your kaiju egg!")
		Events.display_player_message("Take Care of your kaiju and it can grow to be strong, or cute!")
		Events.display_player_message("Play with your kaiju and find yummy cookies to feed it")
		Events.display_player_message("Clean up after them or they will get mad!")
		Events.display_player_message("Tap on your egg to hatch!")
		intro = true
	pass

func _on_pet_pressed()->void:
	if intro:
		base_body._on_click_input_event()
		pet.queue_free()
		pass
	else:
		return
