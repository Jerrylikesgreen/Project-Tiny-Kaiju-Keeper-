class_name MainScene extends Control

@onready var title_screen: TitleScreen = %TitleScreen

func _ready() -> void:
	if !Globals.new_game:
		title_screen.set_visible(false)
		Events.mini_game_ended_signal()
	
	await get_tree().process_frame        # wait one frame so children exist
	Globals.load_game()                   # path to BaseBody is now valid
