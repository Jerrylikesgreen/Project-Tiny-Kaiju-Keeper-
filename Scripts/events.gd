extends Node
signal happiness_changed(happyness_text : String, value:float)  
signal hunger_changed(hunger_text: String, value:float)  
signal hygiene_changed(hygiene_text: String, value:float)  
signal game_state
signal pet_event_signal(listener, event)
signal change_pet_animation(animation: String)
signal play_sfx_signal(index: int)

const THRESHOLD := 0.7
var _happy_sent := false     # false  → haven’t sent “Happy” yet
var event_list: Dictionary[String, float]

## ------------------------------------------------------------------
## 1.  Tiny helper that translates a %‑value into an animation name
## ------------------------------------------------------------------
func _anim_for_level(value: float) -> String:
	if value > 0.7:
		emit_signal("play_sfx_signal", SFX.Track.CHIRP)
		return "Happy"
	elif value > 0.4:
		emit_signal("play_sfx_signal", SFX.Track.CHIRP)
		return "Idle"
	elif value > 0.1:
		emit_signal("play_sfx_signal", SFX.Track.ROAR)
		return "Mad"
	return "Dead"          # ≤ 0.1 – optional fallback



func _on_need_changed(sig_name: String, value: float) -> void:
	emit_signal(sig_name, str(value), value)

	emit_signal("change_pet_animation", _anim_for_level(value))
	print(_anim_for_level(value))



func happiness_changed_value(new_value: float) -> void:
	emit_signal("happiness_changed", str(new_value), new_value)

	if new_value > THRESHOLD:
		if not _happy_sent:
			emit_signal("change_pet_animation", "Happy")
			_happy_sent = true
	else:
		_happy_sent = false       # we dropped below 0.7 → reset


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
