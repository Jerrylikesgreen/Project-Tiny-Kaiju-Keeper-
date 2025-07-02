class_name PlayButton extends Button


@export var play_rate:int = 10

func _on_pressed() -> void:
	var rate = 0.01 * play_rate
	var value = Globals.current_happiness + rate
	Globals.set_current_happiness(value)
	push_warning("Clean Button Pressed ", value)
