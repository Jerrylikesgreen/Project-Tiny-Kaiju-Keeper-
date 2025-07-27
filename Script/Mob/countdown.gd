class_name CountDown
extends Label

@onready var timer      : Timer = %Timer
@onready var pause_mgr  : Node  = get_node("/root/Pause")
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var pop_up: Control = %PopUp
@onready var pop_up_2: Control = %PopUp2
@onready var player_camera: MiniPlayerCamera = %PlayerCamera

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
	text  = str(value)

	if value <= 0:
		timer.stop()
		Events.mini_game_started_signal()
		queue_free()
