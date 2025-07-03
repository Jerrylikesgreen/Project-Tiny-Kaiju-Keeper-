class_name BGM extends AudioStreamPlayer
## Node that controls Background music for thhe game, depending on Game State and other variables. 

@export var fade_enabled: bool = true 


enum Track { ## [ Enum: LOGICAL_NAME → int ]  Refrences the differant tracks Player can play. 
	EGG_1,                   ## 0
	BABY_1,                  ## 1
	TODDLER_1,               ## 2
	JUVENILE_1,              ## 3 
	ADULT_1,                 ## 4
	NAPTIME_SWEET_KAIJU,     ## 5
	THEY_GROW_UP_SO_FAST_1   ## 6
}

## [ Lookup table: enum value → AudioStream ] Refrence to each Path for each Track. 
const TRACK_STREAMS := {
	Track.ADULT_1:                 preload("res://Assets/OGG/Adult (1).ogg"),
	Track.BABY_1:                  preload("res://Assets/OGG/Baby (1).ogg"),
	Track.EGG_1:                   preload("res://Assets/OGG/Egg (1).ogg"),
	Track.JUVENILE_1:              preload("res://Assets/OGG/Juvenile (1).ogg"),
	Track.NAPTIME_SWEET_KAIJU:     preload("res://Assets/OGG/Naptime, sweet kaiju (2).ogg"),
	Track.THEY_GROW_UP_SO_FAST_1:  preload("res://Assets/mp3/They grow up so fast (1).ogg"),
	Track.TODDLER_1:               preload("res://Assets/OGG/Toddler (1).ogg")
}

var _current_track : Track        ## remember what’s playing

func _ready() -> void:
	Events.game_state.connect(_update_track)
	Events.start_game.connect(_on_start_game)


func play_track(track: Track, fade_time: float = 1.0) -> void:  ## Function that plays a track that was passed through. 
	if track == _current_track:         
		return

	if playing:
		_fade_out_then_switch(track, fade_time)
	else:
		_switch_stream(track)
		_fade_in(fade_time)
func _update_track()->void: ## Function that calls pl_track and assigns Track based on current_game_state
	if Globals.current_game_state == 0: ## GUI 
		play_track(Track.NAPTIME_SWEET_KAIJU)
	if Globals.current_game_state == 1: ## MAIN
		play_track(Track.EGG_1)

func _fade_out_then_switch(new_track: Track, t: float) -> void:
	if not fade_enabled or t <= 0.0:
		stop()
		_switch_stream(new_track)
		_play_no_fade()
		return

	var tw := get_tree().create_tween()
	tw.tween_property(self, "volume_db", -80, t).set_trans(Tween.TRANS_SINE)
	tw.tween_callback(Callable(self, "_on_fade_out_done").bind(new_track, t))

func _play_no_fade() -> void:
	volume_db = 0
	play()


func _on_fade_out_done(new_track: Track, t: float) -> void: ## When Fadeout is done, switches track to reloop. 
	stop()
	_switch_stream(new_track)
	_fade_in(t)

func _fade_in(t: float) -> void:
	volume_db = -80
	play()
	get_tree().create_tween() \
		.tween_property(self, "volume_db", 0, t) \
		.set_trans(Tween.TRANS_SINE)

func _switch_stream(track: Track) -> void:
	_current_track = track
	stream = TRACK_STREAMS[track]

func _on_finished() -> void:
	play()

func _on_start_game():
	play_track(Track.NAPTIME_SWEET_KAIJU)
