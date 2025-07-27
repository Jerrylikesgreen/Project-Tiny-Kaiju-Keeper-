class_name GameOverArea extends Area2D
signal win
signal lose

var _cookie_count := 0


@onready var player_camera: MiniPlayerCamera = %PlayerCamera

func _ready() -> void:
	Events.mini_game.connect(_on_mini_game_signal)


func _on_mini_game_signal(hazard: String) -> void:
	match hazard:
		"Cookie":
			_cookie_count += 1
		"Poop":
			_cookie_count -= 1
		_:
			return  # ignore other hazards


func _on_body_entered(body: Node2D) -> void:
	var score = Globals.get_cookie_count()
	player_camera.shake()
	if _cookie_count > 0:
		_on_game_win()
	else:
		_on_game_over()



func _on_game_win():
	var happy_gain = Globals.get_current_happiness() + 0.5
	Globals.set_current_happiness(happy_gain)
	Globals.set_cookie_count(_cookie_count)
	SceneManager.goto_main(7.0)

func _on_game_over():
	var score = Globals.get_current_happiness() - 0.1
	Globals.set_current_happiness(score)
	var new_cookie_count = Globals.get_cookie_count() + _cookie_count
	Globals.set_cookie_count(new_cookie_count)
	SceneManager.goto_main(7.0)
