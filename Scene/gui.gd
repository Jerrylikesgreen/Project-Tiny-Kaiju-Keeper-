class_name GUI extends CanvasLayer
@onready var menu_screen: MenuScreen = $MenuScreen


func _on_menu_pressed() -> void:
	menu_screen.set_visible(true)
	pass # Replace with function body.
