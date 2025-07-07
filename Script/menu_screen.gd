class_name MenuScreen extends PanelContainer
@onready var sound_menu: CanvasLayer = $SoundMenu


func _on_back_pressed() -> void:
	set_visible(false)


func _on_sound_pressed() -> void:
	sound_menu.set_visible(true)
