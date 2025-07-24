extends Node
## ─────────────────────────────────────────────────────────────────────────
##  Events  (autoload singleton)
## ─────────────────────────────────────────────────────────────────────────
signal happiness_changed(text: String, value: float)
signal hunger_changed(text: String, value: float)
signal hygiene_changed(text: String, value: float)
signal game_state(value: int)
signal pet_event_signal(listener, event)
signal change_pet_animation(anim: String)
signal play_sfx_signal(track_id: int)
signal gui_sfx(track_id: int)
signal poop(value:bool)
signal evolve(value:int)
signal game_start
signal game_stop
signal mini_game(hazard:String)
signal mini_game_ended
signal mini_game_started
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




func game_state_change(value:int)->void:
	emit_signal("game_state", value)
	Globals.set_game_state(value)
	print(value)

func pet_event(event: String, value: float)-> void:
	print("Event")
	event_list[event]=value
	emit_signal("pet_event_signal", event, value)
	pass 

func sfx_trigger(sfx: SFX.Track ):
	emit_signal("play_sfx_signal", sfx)
	print(sfx)

func mini_game_hazard_trigger(hazard:String)->void:
	emit_signal("mini_game", hazard)

func mini_game_ended_signal():
	emit_signal("mini_game_ended")
	
func mini_game_started_signal():
	await emit_signal("mini_game_started")
