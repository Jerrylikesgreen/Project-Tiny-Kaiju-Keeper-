class_name GameOverArea extends Area2D




func _on_body_entered(body: Node2D) -> void:
	_on_game_over()




func _on_game_over() -> void:
	Globals.save_game()
	SceneManager.goto_main()
	pass
