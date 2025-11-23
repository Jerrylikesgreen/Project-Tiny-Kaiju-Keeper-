class_name SFX extends AudioStreamPlayer


@export var sfx_bank: Array[AudioStream]  

enum Track { ## [ Enum: LOGICAL_NAME → int ]  Refrences the differant tracks Player can play. 
	EVOLUTION,                   ## 0
	BLIP,
	CHIRP,
	FLAP,
	MUNCH_1,
	MUNCH_2,
	ROAR
}

var _current_track : Track        ## remember what’s playing

func _ready() -> void:
	Events.play_sfx_signal.connect(_on_play_sfx)

func play_track(track: Track) -> void:

	_switch_stream(track)
	play()
	print_debug("Track being played: %s" % track)

func _switch_stream(track: Track) -> void:
	if track < 0 or track >= sfx_bank.size():
		push_warning("SFX index %d is out of range (bank size = %d)" %
					 [track, sfx_bank.size()])
		return
	if sfx_bank[track] == null:
		push_warning("SFX bank entry %d is empty" % track)
		return
	_current_track = track
	stream = sfx_bank[track]

func _on_play_sfx(index: int) -> void:## iNT: iNDEX TO REFRENCE A TRACK STORED ON AN ENUM. 
	if index < 0 or index >= sfx_bank.size():
		push_warning("SFX index %d is out of range (bank size = %d)" %
					 [index, sfx_bank.size()])
		return
	if sfx_bank[index] == null:
		push_warning("SFX bank entry %d is empty" % index)
		return
	stream = sfx_bank[index]
	play()
	print_debug("Playing")
