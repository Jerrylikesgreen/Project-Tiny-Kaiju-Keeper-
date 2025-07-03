extends Node
signal happiness_changed(happyness_text : String, value:float)  
signal hunger_changed(hunger_text: String, value:float)  
signal hygiene_changed(hygiene_text: String, value:float)  
signal game_state
signal pet_event_signal(listener, event)
signal change_pet_animation(animation: String)
signal start_game
var event_list: Dictionary[String, float]
## ------------------------------------------------------------------
## 1.  Tiny helper that translates a %‑value into an animation name
## ------------------------------------------------------------------
func _anim_for_level(value: float) -> String:
	if value > 0.7:
		return "Happy"
	elif value > 0.4:
		return "Idle"
	elif value > 0.1:
		return "Mad"
	return "Dead"          # ≤ 0.1 – optional fallback



func _on_need_changed(sig_name: String, value: float) -> void:
	## 1) Re‑emit the raw‑value signal so the UI can listen
	emit_signal(sig_name, str(value), value)

	## 2) Pick the right animation and broadcast it
	emit_signal("change_pet_animation", _anim_for_level(value))
	print(change_pet_animation, value)

func happiness_changed_value(value: float) -> void:
	_on_need_changed("happiness_changed", value)

func hunger_changed_value(value: float) -> void:
	_on_need_changed("hunger_changed", value)

func hygiene_changed_value(value: float) -> void:
	_on_need_changed("hygiene_changed", value)


func game_state_change()->void:
	emit_signal("game_state")
	pass

func pet_event(event: String, value: float)-> void:
	event_list[event]=value
	emit_signal("pet_event_signal", event, value)
	pass 
