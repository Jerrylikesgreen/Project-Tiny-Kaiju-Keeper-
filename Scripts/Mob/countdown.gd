class_name CountDown
extends Label

@onready var timer      : Timer = %Timer
@onready var pause_mgr  : Node  = get_node("/root/Pause")
@onready var pop_up: Control = %PopUp
@onready var pop_up_2: Control = %PopUp2
@onready var player_camera: MiniPlayerCamera = %PlayerCamera
@onready var mini_game_hud: Control = %MiniGameHUD
@onready var mini_sfx_2: MiniSFX = %mini_sfx2

@export var start_value : int   = 3     # Editable in the inspector
var value : int

func _ready() -> void:
	value = start_value
	text  = str(value)
	player_camera.make_current()
	timer.timeout.connect(_on_timeout)   # ← missing line
	timer.start()
	


func _on_timeout() -> void:
	value -= 1
	mini_sfx_2.set_stream(mini_sfx_2.blip)
	mini_sfx_2.play()
	text  = str(value)

	if value <= 0:
		timer.stop()
		Events.mini_game_started()
		queue_free()
