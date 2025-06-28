class_name BGM extends AudioStreamPlayer

## ---[ 1. Enum: LOGICAL_NAME → int ]---
enum Track {
	EGG_1,                   ## 0
	BABY_1,                  ## 1
	TODDLER_1,               ## 2
	JUVENILE_1,              ## 3 
	ADULT_1,                 ## 4
	NAPTIME_SWEET_KAIJU,     ## 5
	THEY_GROW_UP_SO_FAST_1   ## 6
}

## ---[ 2. Lookup table: enum value → AudioStream ]---
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
	play_track(Track.NAPTIME_SWEET_KAIJU)
	Events.game_state.connect(_update_track)


func play_track(track: Track) -> void:
	$AudioStreamPlayer.stream = TRACK_STREAMS[track]
	$AudioStreamPlayer.play()

func _update_track()->void:
	if Globals.current_game_state == 0: ## GUI 
		play_track(Track.NAPTIME_SWEET_KAIJU)
	if Globals.current_game_state == 1: ## MAIN
		play_track(Track.EGG_1)
