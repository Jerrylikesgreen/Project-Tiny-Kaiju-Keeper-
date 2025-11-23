extends PlayerCamera


@onready var game_over_area: GameOverArea = %GameOverArea



func _ready() -> void:
	game_over_area.game_end.connect(_on_game_end)



func _on_game_end()->void:
	make_current()
