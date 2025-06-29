extends Node
signal happiness_changed(happyness_text : String, value:float)  
signal hunger_changed(hunger_text: String, value:float)  
signal hygiene_changed(hygiene_text: String, value:float)  
signal game_state


func happiness_changed_value(value: float) -> void:
	emit_signal("happiness_changed", str(value), value)
	print("happy")
func hunger_changed_value(value: float) -> void:
	emit_signal("hunger_changed", str(value), value)
	print("hunger")
func hygiene_changed_value(value: float) -> void:
	emit_signal("hygiene_changed", str(value), value)
	print("hygine")



func game_state_change()->void:
	emit_signal("game_state")
	pass
