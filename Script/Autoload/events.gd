extends Node
## ─────────────────────────────────────────────────────────────────────────
##  Events  (autoload singleton)
## ─────────────────────────────────────────────────────────────────────────
signal happiness_changed(text: String, value: float)
signal hunger_changed(text: String, value: float)
signal hygiene_changed(text: String, value: float)
signal game_state
signal pet_event_signal(listener, event)
signal change_pet_animation(anim: String)
signal play_sfx_signal(track_id: int)
signal gui_sfx(track_id: int)

const THRESHOLD := 0.7

## If you still need this elsewhere, keep it
var event_list: Dictionary[String, float] = {}


## Track the last band for each individual stat
var _band_last := {
	"happiness": -1,
	"hunger":    -1,
	"hygiene":   -1,
}

func _anim_for_level(stat_name: String, value: float) -> String:
	value = clamp(value, 0.0, 1.0)            # safety

	var band : int
	var anim : String
	var sfx  : int

	if value > 0.9:
		
		band = 3
		anim = "Happy"
		sfx  = SFX.Track.CHIRP
		if stat_name == "happiness":
			Globals.mothlyn_points = Globals.mothlyn_points + 1
		if stat_name == "hunger":
			Globals.gigazilla_points = Globals.gigazilla_points + 1
		
	elif value > 0.5:
		band = 2
		anim = "Idle"
		sfx  = SFX.Track.CHIRP
	elif value > 0.2:
		band = 1
		anim = "Mad"
		sfx  = SFX.Track.ROAR
	else:
		band = 0
		anim = "Dead"
		sfx  = SFX.Track.ROAR

	# Emit SFX only when THIS stat crosses a threshold
	if band != _band_last[stat_name]:
		_band_last[stat_name] = band
		emit_signal("play_sfx_signal", sfx)
		print("SFX:", anim, "for", stat_name)
	

	
	return anim




func game_state_change()->void:
	emit_signal("game_state")
	pass

func pet_event(event: String, value: float)-> void:
	event_list[event]=value
	emit_signal("pet_event_signal", event, value)
	pass 

func sfx_trigger(sfx: SFX.Track ):
	emit_signal("play_sfx_signal", sfx)
	print(sfx)
