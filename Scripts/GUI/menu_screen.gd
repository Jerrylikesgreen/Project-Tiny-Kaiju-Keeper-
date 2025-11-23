class_name MenuScreen
extends PanelContainer

@onready var sound_menu: CanvasLayer = $SoundMenu
@onready var pause_mgr   : Node      = get_node("/root/Pause")
@onready var save_button: Button = %SaveButton
@onready var back_button: Button = %BackButton
@onready var pause_button: Button = %PauseButton
@onready var sound_button: Button = %SoundButton
@export var _paused:bool = false


func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	sound_button.pressed.connect(_on_sound_button_pressed)
	pause_button.pressed.connect(_on_pause_button_pressed)
	save_button.pressed.connect(_on_save_button_pressed)

func _on_back_pressed() -> void:
	if !_paused:set_visible(false)



func _on_sound_button_pressed() -> void:
	sound_menu.visible = true  



func _on_pause_button_pressed() -> void:
	if _paused == false:
		_paused      = true
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		pause_mgr.toggle_pause()   # this sets get_tree().paused = true
	else:
		_paused      = false
		process_mode = Node.PROCESS_MODE_PAUSABLE
		pause_mgr.toggle_pause()

func _on_save_button_pressed() -> void:
	Globals.save_game()
