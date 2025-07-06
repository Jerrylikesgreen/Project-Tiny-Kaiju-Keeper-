class_name GuiSfx extends AudioStreamPlayer





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


## [ Lookup table: enum value → AudioStream ] Refrence to each Path for each Track. 
const TRACK_STREAMS := {
	Track.EVOLUTION: preload("res://Assets/OGG/Upgrade.ogg"),
	Track.BLIP:  preload("res://Assets/OGG/Blip.ogg"),
	Track.CHIRP: preload("res://Assets/OGG/Chirp Chirp.ogg"),
	Track.FLAP: preload("res://Assets/OGG/Flap.ogg"),
	Track.MUNCH_1: preload("res://Assets/OGG/Munch 1.ogg"),
	Track.MUNCH_2: preload("res://Assets/OGG/Munch 2.ogg"),
	Track.ROAR: preload("res://Assets/OGG/Roar.ogg")

}

var _current_track : Track        ## remember what’s playing

func _ready() -> void:
	Events.GUI_SFX.connect(_on_call)


func _on_call(NewTrack:Track):
	_current_track = NewTrack 
	play(NewTrack)
