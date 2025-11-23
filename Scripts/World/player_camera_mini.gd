class_name MiniPlayerCamera
extends PlayerCamera            # Camera2D descendant

@export var base_zoom       : Vector2 = Vector2.ONE
@export var noise_frequency : float  = 15.0       # Hz of jitter
@onready var game_over_area: GameOverArea = %GameOverArea


var _noise_timer : float = 0.0

func _ready() -> void:
	zoom = base_zoom
	Events.mini_game.connect(_on_mini_game_signal)

func _process(delta: float) -> void:
	_apply_shake(delta)


func _apply_shake(delta: float) -> void:
	if _trauma > 0.0:
		_noise_timer += delta * noise_frequency
		_trauma = max(_trauma - _decay_rate * delta, 0.0)

		var amt   := pow(_trauma, 2)             # smoother fall‑off
		offset = Vector2(
			randf_range(-1, 1) * amt,
			randf_range(-1, 1) * amt
		)
	else:
		offset = Vector2.ZERO



# ——— event hook ———
func _on_mini_game_signal(hazard: String) -> void:
	if hazard == "Poop":
		shake(3, 0.35)         # try 8‑12 px for a visible kick
