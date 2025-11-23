class_name ButtonSFX
extends AudioStreamPlayer

@export var sfx_bank: Array[AudioStream] = []  

enum Track { BLIP, ROAR, BABY, CLEAN }

@export var _current_track : Track = Track.BLIP


func _ready() -> void:
	_apply_track(_current_track)


func play_sfx(new_track: Track) -> void:

	_current_track = new_track
	_apply_track(_current_track)
	play()


func _apply_track(track_idx: int) -> void:
	if track_idx < 0 or track_idx >= sfx_bank.size():
		push_error("Track index %d is outside sfx_bank range." % track_idx)
		return

	stream = sfx_bank[track_idx]
