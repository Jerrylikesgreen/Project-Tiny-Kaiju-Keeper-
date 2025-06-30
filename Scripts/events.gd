extends Node
signal happiness_changed(happyness_text : String, value:float)  
signal hunger_changed(hunger_text: String, value:float)  
signal hygiene_changed(hygiene_text: String, value:float)  
signal game_state
signal resource_alert(alert:String, alert_rate:int)

func happiness_changed_value(value: float) -> void:
	if Globals.current_happiness == 0.9:
		emit_signal("resource_alert", "Happyieness is at 0.9", 0)
	emit_signal("happiness_changed", str(value), value)
	print("happy")
func hunger_changed_value(value: float) -> void:
	emit_signal("hunger_changed", str(value), value)
	print("hunger")
func hygiene_changed_value(value: float) -> void:
	emit_signal("hygiene_changed", str(value), value)
	print("hygiene")



func game_state_change()->void:
	emit_signal("game_state")
	pass
