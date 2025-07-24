class_name BGM
extends AudioStreamPlayer
## Node that controls background music, with optional fades.

# ─── OPTIONS ─────────────────────────────────────────────
@export var fade_enabled   : bool  = true
@export var fade_in_time   : float = 1.0        # seconds
@export var fade_out_time  : float = 1.0        # seconds

enum Track {
	EGG_1, BABY_1, TODDLER_1, JUVENILE_1,
	ADULT_1, NAPTIME_SWEET_KAIJU, THEY_GROW_UP_SO_FAST_1
}

var _current_track : Track
var _last_gameplay_track : Track   # remember where we left off

const TRACK_STREAMS := {
	Track.ADULT_1:                preload("res://Asset/OGG/Adult (1).ogg"),
	Track.BABY_1:                 preload("res://Asset/OGG/Baby (1).ogg"),
	Track.EGG_1:                  preload("res://Asset/OGG/Egg (1).ogg"),
	Track.JUVENILE_1:             preload("res://Asset/OGG/Juvenile (1).ogg"),
	Track.NAPTIME_SWEET_KAIJU:    preload("res://Asset/OGG/Naptime, sweet kaiju (2).ogg"),
	Track.THEY_GROW_UP_SO_FAST_1: preload("res://Asset/mp3/They grow up so fast (1).ogg"),
	Track.TODDLER_1:              preload("res://Asset/OGG/Toddler (1).ogg")
}

# ─── LIFECYCLE ───────────────────────────────────────────
func _ready() -> void:
	play_track(Track.THEY_GROW_UP_SO_FAST_1)
	Events.evolve.connect(_on_evolve)
	Events.game_start.connect(_on_game_start)

# ─── PUBLIC API ──────────────────────────────────────────
func set_fade_enabled(enabled: bool) -> void:
	fade_enabled = enabled

## Pass a custom fade duration (seconds) or null to use defaults.
func play_track(track: Track, custom_time: float = -1.0) -> void:
	if track == _current_track:
		return

	var out_t : float = custom_time if custom_time != null else fade_out_time
	var in_t  : float = custom_time if custom_time != null else fade_in_time

	if playing:
		_fade_out_then_switch(track, out_t, in_t)
	else:
		_switch_stream(track)
		_fade_in(in_t)

# ─── INTERNAL ────────────────────────────────────────────
func _fade_out_then_switch(next_track: Track, out_t: float, in_t: float) -> void:
	if not fade_enabled or out_t <= 0:
		stop()
		_switch_stream(next_track)
		_fade_in(in_t)
		return

	var tw := get_tree().create_tween()
	tw.tween_property(self, "volume_db", -80, out_t).set_trans(Tween.TRANS_SINE)
	tw.tween_callback(Callable(self, "_on_fade_out_finished").bind(next_track, in_t))

func _on_fade_out_finished(next_track: Track, in_t: float) -> void:
	stop()
	_switch_stream(next_track)
	_fade_in(in_t)

func _fade_in(t: float) -> void:
	if not fade_enabled or t <= 0:
		volume_db = 0
		play()
		return

	volume_db = -30
	play()
	get_tree().create_tween()\
		.tween_property(self, "volume_db", 0, t)\
		.set_trans(Tween.TRANS_SINE)

func _switch_stream(track: Track) -> void:
	_current_track = track
	stream = TRACK_STREAMS[track]

# ─── SIGNAL HANDLERS ─────────────────────────────────────


func _on_evolve(new_track: Track) -> void:
	_last_gameplay_track = new_track
	play_track(new_track)

func _on_game_start() -> void:
	if _last_gameplay_track:
		play_track(_last_gameplay_track, 0.2)
	else:
		play_track(Track.BABY_1,0.2)
