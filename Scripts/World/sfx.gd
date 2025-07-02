class_name SFX extends AudioStreamPlayer


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



func play_track(track: Track, fade_time: float = 1.0) -> void:  ## Function that plays a track that was passed through. 
	if track == _current_track:         
		return

	if playing:
		_fade_out_then_switch(track, fade_time)
	else:
		_switch_stream(track)
		_fade_in(fade_time)
		
##func _update_track()->void: ## Function that calls pl_track and assigns Track based on current_game_state
##	if Globals.current_game_state == 0: ## GUI 
##		play_track(Track.NAPTIME_SWEET_KAIJU)
##	if Globals.current_game_state == 1: ## MAIN
##		play_track(Track.EGG_1)

func _fade_out_then_switch(new_track: Track, t: float) -> void:## {PRIVATE} Helper to fade bgm  
	var tw := get_tree().create_tween() ## Create tween
	tw.tween_property(self, "volume_db", -80, t).set_trans(Tween.TRANS_SINE) ## Define tween properites 

	var cb := Callable(self, "_on_fade_out_done").bind(new_track, t)
	tw.tween_callback(cb)


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
