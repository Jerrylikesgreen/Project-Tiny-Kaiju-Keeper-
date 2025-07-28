class_name CookieCount extends Label


func _ready() -> void:
	Events.mini_game_ended.connect(_on_mini)
	_on_mini()
	
	
func _on_mini()->void:
	var update_count = Globals.get_cookie_count()
	set_text(str(update_count))
	
