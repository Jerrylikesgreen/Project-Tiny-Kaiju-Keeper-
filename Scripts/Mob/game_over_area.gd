class_name GameOverArea extends Area2D
var _cookie_count := 0

signal game_end

@onready var player_camera: MiniPlayerCamera = %PlayerCamera

func _ready() -> void:
	Events.mini_game.connect(_on_mini_game_signal)
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D) ->void:
	if body.is_in_group("Pet"):
		if _cookie_count > 2:
			_game_win()
		else:
			_game_over()



func _on_mini_game_signal(hazard: String) -> void:
	match hazard:
		"Cookie":
			_cookie_count += 1
		"Poop":
			_cookie_count -= 1
		_:
			return  # ignore other hazards



func _game_win():
	emit_signal("game_end")
	var happy_gain = Globals.get_current_happiness() + 0.5
	Globals.set_current_happiness(happy_gain)
	Globals.set_cookie_count(_cookie_count)
	_switch_scene()
	print("{ppop}")
	
	

func _game_over():
	emit_signal("game_end")
	var score = Globals.get_current_happiness() - 0.1
	Globals.set_current_happiness(score)
	var new_cookie_count = Globals.get_cookie_count() + _cookie_count
	Globals.set_cookie_count(new_cookie_count)
	_switch_scene()


func _switch_scene()->void:
	SceneManager.goto_main(7.0)
