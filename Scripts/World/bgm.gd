class_name BGM extends AudioStreamPlayer
## Node that controls Background music for thhe game, depending on Game State and other variables. 



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
	Track.ADULT_1:                 preload("res://Assets/mp3/Adult (1).mp3"),
	Track.BABY_1:                  preload("res://Assets/mp3/Baby (1).mp3"),
	Track.EGG_1:                   preload("res://Assets/mp3/Egg (1).mp3"),
	Track.JUVENILE_1:              preload("res://Assets/mp3/Juvenile (1).mp3"),
	Track.NAPTIME_SWEET_KAIJU:     preload("res://Assets/mp3/Naptime, sweet kaiju.mp3"),
	Track.THEY_GROW_UP_SO_FAST_1:  preload("res://Assets/mp3/They grow up so fast (1).ogg"),
	Track.TODDLER_1:               preload("res://Assets/mp3/Toddler (1).mp3")
}

func _ready() -> void:
	play_track(Track.NAPTIME_SWEET_KAIJU) ## Ensures audio gets played at start. 
	Events.game_state.connect(_update_track)


func play_track(track: Track) -> void: ## Function that plays the track that was passed through. 
	stream = TRACK_STREAMS[track]
	play()

func _update_track()->void: ## Function that calls pl_track and assigns Track based on current_game_state
	if Globals.current_game_state == 0: ## GUI 
		play_track(Track.NAPTIME_SWEET_KAIJU)
	if Globals.current_game_state == 1: ## MAIN
		play_track(Track.EGG_1)
