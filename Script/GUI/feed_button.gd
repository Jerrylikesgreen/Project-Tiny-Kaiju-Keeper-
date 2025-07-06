class_name FeedButton extends Button

@export var feed_rate: int = 10

func _on_pressed() -> void:
	var rate = 0.01 * feed_rate
	var value = Globals.current_hunger + rate
	Globals.set_current_hunger(value)
	push_warning("FEED Pressed ", value)
	Events.sfx_trigger(SFX.Track.BLIP)
