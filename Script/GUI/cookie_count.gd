extends Label

var _cookie_count: int = 0

func _ready() -> void:
	Events.mini_game.connect(_on_mini_game_signal)
	_update_label()

func _on_mini_game_signal(hazard: String) -> void:
	match hazard:
		"Cookie":
			_cookie_count += 1
		"Poop":
			_cookie_count -= 1
		_:
			return  # ignore other hazards

	_update_label()

	if _cookie_count > 2:
		_on_game_win()
	elif _cookie_count < 0:
		_on_game_over()

func _update_label() -> void:
	text = str(_cookie_count)   # or set_text(str(_cookie_count))

func _on_game_win() -> void:
	SceneManager.goto_main()
	Events.set_current_happiness(0.3)
	pass

func _on_game_over() -> void:
	SceneManager.goto_main()
	pass
