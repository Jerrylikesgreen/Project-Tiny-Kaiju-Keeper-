extends Node2D


var _cookie_count := 0
@onready var count_player: AnimationPlayer = %CountPlayer
@onready var mini_sfx_2: MiniSFX = %mini_sfx2


func _ready() -> void:
	Events.mini_game.connect(_on_mini_game_signal)

func _on_mini_game_signal(hazard: String) -> void:
	
	match hazard:
		"Cookie":
			_cookie_count += 1
			count_player.play("Tick")
			mini_sfx_2.set_stream(mini_sfx_2.cookie)
			mini_sfx_2.play()
		"Poop":
			_cookie_count -= 1
			mini_sfx_2.set_stream(mini_sfx_2.roar)
			mini_sfx_2.play()
		_:
			return  # ignore other hazards
