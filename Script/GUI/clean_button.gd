class_name CleanButton extends Button

@export var clean_rate: int = 10

@onready var button_sfx: ButtonSFX = %ButtonSFX


func _on_pressed() -> void:
	var rate = 0.01 * clean_rate
	var value = Globals.current_hygiene + rate
	Globals.set_current_hygiene(value)
	push_warning("Clean Button Pressed ", value)
	Events.sfx_trigger(SFX.Track.BLIP)
	button_sfx.play_sfx(button_sfx.Track.CLEAN)
	if Globals.poop_spawned:
		Events.emit_signal("poop", false)
		print("Faaaaaaaaaaaaslslslsl")
