extends Node


const MINI_GAME = preload("res://Scene/mini_game.tscn")
const MAIN_SCENE = preload("res://Scene/main_scene.tscn")


## ───────── TWEAKABLE ─────────
@export var fade_color      : Color = Color.BLACK
@export var default_fade_s  : float = 0.5     # seconds

## ───────── INTERNAL ─────────
var _fade_rect : ColorRect
var _tween     : Tween

func _ready() -> void:
	_init_fade_layer()
	

# ─── PUBLIC API ────────────────────────────────────────────────────────────
func goto_main(fade_time := -1.0) -> void:
	_change_to_packed(MAIN_SCENE, fade_time)
	var c = Globals.get_cookie_count()
	Events.display_player_message("You gained %s cookies" % [c])

	
	

func goto_mini_game(fade_time := -1.0) -> void:
	Globals.save_game()        
	_change_to_packed(MINI_GAME, fade_time)

func change_to(path: String, fade_time := -1.0) -> void:
	_change_to_file(path, fade_time)

# ─── CORE LOGIC ────────────────────────────────────────────────────────────
func _change_to_packed(scene: PackedScene, fade_time: float) -> void:
	await _fade_out(fade_time)
	get_tree().change_scene_to_packed(scene)
	await _fade_in(fade_time)

func _change_to_file(path: String, fade_time: float) -> void:
	await _fade_out(fade_time)
	get_tree().change_scene_to_file(path)
	await _fade_in(fade_time)

# ─── FADE LAYER SETUP ─────────────────────────────────────────────────────
func _init_fade_layer() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 100
	add_child(layer)

	_fade_rect = ColorRect.new()
	_fade_rect.modulate = Color(fade_color.r, fade_color.g, fade_color.b, 0.0)  # α = 0
	_fade_rect.size = get_viewport().size
	_fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(_fade_rect)

	get_viewport().connect("size_changed", Callable(self, "_on_vp_resize"))

# ─── FADE‑OUT ─────────────────────────────────────────────────────────────
func _fade_out(seconds: float) -> Signal:
	var dur := seconds - 6.5 if seconds > 0 else default_fade_s
	if _tween: _tween.kill()

	_fade_rect.visible = true
	_tween = create_tween()                         # keep the Tween itself
	_tween.tween_property(_fade_rect, "modulate:a", 1.0, dur) \
		  .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	return _tween.finished                          # wait for completion

# ─── FADE‑IN ──────────────────────────────────────────────────────────────
func _fade_in(seconds: float) -> Signal:
	var dur := seconds - 0.5 if seconds > 0 else default_fade_s
	if _tween: _tween.kill()

	_tween = create_tween()
	_tween.tween_property(_fade_rect, "modulate:a", 0.0, dur) \
		  .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	return _tween.finished
