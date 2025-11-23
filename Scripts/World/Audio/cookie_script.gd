class_name Cookie extends AnimatedSprite2D

@onready var sfx: AudioStreamPlayer = $SFX

@export var speed_px_per_sec : float = 200.0   # ← tweak in Inspector
var _velocity : Vector2 = Vector2.RIGHT        # always move right

signal cookie_ate

var mini_game:bool = false


func _ready() -> void:
	_run_cookie()


func _run_cookie():
	play()
	sfx.play()

func _physics_process(delta: float) -> void:
	if !mini_game:
		return
	if mini_game:
		position += _velocity * speed_px_per_sec * delta


func _on_animation_looped() -> void:
	emit_signal("cookie_ate")
	queue_free()
	print("Looped")
	pass # Replace with function body.
