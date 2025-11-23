class_name MiniSFX extends AudioStreamPlayer


@export var flap: AudioStream
@export var cookie: AudioStream
@export var poop: AudioStream
@export var blip: AudioStream
@export var roar: AudioStream

func _ready() -> void:
	Events.mini_game.connect(_on_mini_game_signal)




func _on_mini_game_signal(hazard: String):
	if hazard == "Cookie":
		set_stream(cookie)
		print(hazard)
	if hazard == "Poop":
		set_stream(poop)
	pass
