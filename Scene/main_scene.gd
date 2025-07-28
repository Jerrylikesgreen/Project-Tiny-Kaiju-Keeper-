class_name Level1 extends Control

@onready var pet: PetButton = %Pet
@onready var base_body: BaseBody = %BaseBody

var intro:bool = false

func  _ready() -> void:
	Events.game_start.connect(_on_game_start)
	pet.pressed.connect(_on_pet_pressed)



func _on_game_start()->void:
	if !Globals.new_game:
		Events.display_player_message("Welcome! this is your kaiju egg. In a moment it will hatch into a little Chick.")
		Events.display_player_message("Take Care of your Kaiju and maybe he will grow to be nice and stro...cute.")
		Events.display_player_message("Play with your kaiju and find yummy cookies to feed your pet.")
		Events.display_player_message("Clean up after them or they will be mad!")
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
