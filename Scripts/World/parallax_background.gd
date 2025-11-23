extends ParallaxBackground

@export var base_speed := 120.0   
@onready var game_over_area: GameOverArea = %GameOverArea

func _process(delta):
	scroll_offset.x += base_speed * delta          

func _ready() -> void:
	game_over_area.game_end.connect(_on_game_end)
	
func _on_game_end() ->void:
	print("pop")
	if is_visible():
		set_visible(false)
