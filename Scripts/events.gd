extends Node
signal happiness_changed(happyness_text : String, value:float)  
signal hunger_changed(hunger_text: String, value:float)  
signal hygiene_changed(hygiene_text: String, value:float)  
signal game_state
signal pet_event_signal(listener, event)
signal change_pet_animation(animation: String)

var event_list: Dictionary[String, float]

func happiness_changed_value(value: float) -> void:
	emit_signal("happiness_changed", str(value), value)
	if value > .7:
		emit_signal("change_pet_animation", "Happy")
		return
	if value > .4:
		emit_signal("change_pet_animation", "Idle")
		return
	if value > .1:
		emit_signal("change_pet_animation", "Mad")
		return
	print("happy", value)
func hunger_changed_value(value: float) -> void:
	emit_signal("hunger_changed", str(value), value)
	if value > .7:
		emit_signal("change_pet_animation", "Happy")
		return
	if value > .4:
		emit_signal("change_pet_animation", "Idle")
		return
	if value > .1:
		emit_signal("change_pet_animation", "Mad")
		return
	print("hunger")
func hygiene_changed_value(value: float) -> void:
	emit_signal("hygiene_changed", str(value), value)
	if value > .7:
		emit_signal("change_pet_animation", "Happy")
		return
	if value > .4:
		emit_signal("change_pet_animation", "Idle")
		return
	if value > .1:
		emit_signal("change_pet_animation", "Mad")
		return
	print("hygiene")


func game_state_change()->void:
	emit_signal("game_state")
	pass

func pet_event(event: String, value: float)-> void:
	event_list[event]=value
	emit_signal("pet_event_signal", event, value)
	pass 
