extends Node
## ─────────────────────────────────────────────────────────────────────────
##  Events  (autoload singleton)
## ─────────────────────────────────────────────────────────────────────────
signal happiness_changed_signal( value: float)
signal hunger_changed_signal(value: float)
signal hygiene_changed_signal( value: float)
signal game_state(value: GameStateMachine.GameState)
signal play_sfx_signal(track_id: int)
signal play_gui_sfx_signal(track_id: int)
signal game_start_signal
signal game_stop_signal
signal mini_game(hazard:String)
signal mini_game_ended
signal mini_game_started_signal
signal player_message(player_message:String)
signal can_feed(value:bool)
signal evolve_signal(current_growth_state: PetResource.PetGrowthState)
signal intro_ended_signal
signal mini_game_startup
signal poop_signal(v:bool)
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

func play_gui_sfx(track_id: int) ->void:
	emit_signal("play_gui_sfx_signal", track_id)

func game_start()->void:
	emit_signal("game_start_signal")
	Globals.new_game = false

func game_stop()->void:
	emit_signal("game_stop_signal")


func game_state_change(value: GameStateMachine.GameState)->void:
	emit_signal("game_state", value)
	GameStateMachine.set_game_state(value)
	print(value)


func sfx_trigger(sfx: SFX.Track ):
	emit_signal("play_sfx_signal", sfx)
	print(sfx)

func mini_game_hazard_trigger(hazard:String)->void:
	emit_signal("mini_game", hazard)

func mini_game_ended_signal():
	GameStateMachine.set_game_state(GameStateMachine.GameState.MAIN)
	emit_signal("mini_game_ended")
	
func mini_game_started():
	emit_signal("mini_game_started_signal")

func happiness_changed(value: float) ->void:
	emit_signal("happiness_changed_signal", value )
func hunger_changed(value: float) ->void:
	emit_signal("hunger_changed_signal", value )
func hygiene_changed(value: float) ->void:
	emit_signal("hygiene_changed_signal",value )

func trigger_can_feed(value:bool)-> void:
	emit_signal("can_feed", value)

func display_player_message(new_message:String)-> void:
	emit_signal("player_message", new_message)
	
func on_pet_growth_state_change(current_growth_state: PetResource.PetGrowthState) ->void:
	emit_signal("evolve_signal", current_growth_state)
	sfx_trigger(SFX.Track.EVOLUTION)

func intro_ended()->void:
	emit_signal("intro_ended_signal")


func start_mini_game()->void:
	GameStateMachine.set_game_state(GameStateMachine.GameState.MINI)
	emit_signal("mini_game_startup")

func intro()->void:
	display_player_message("Welcome, to Kiaju Keeper!")
	display_player_message("Play with your kaiju to find yummy treats!")
	display_player_message("Click on your egg to help it hatch!")
	game_start()

func poop(v:bool)->void:
	emit_signal("poop_signal", v)
