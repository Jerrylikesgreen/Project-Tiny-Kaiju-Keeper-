extends Label
signal win
signal lose

var _cookie_count := 0


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

	if _cookie_count >= 3:
		_on_game_win()
	elif _cookie_count < 0:
		_on_game_over()

func _update_label(): text = str(_cookie_count)

func _on_game_win():
	var score = Globals.get_current_happiness() + 0.5
	Globals.set_current_happiness(score)
	Globals.save_game()
	SceneManager.goto_main()

func _on_game_over():
	var score = Globals.get_current_happiness() - 0.1
	Globals.set_current_happiness(score)
	Globals.save_game()
	SceneManager.goto_main()
