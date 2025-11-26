class_name Poop extends AnimatedSprite2D


@export var speed_px_per_sec : float = 200.0   # ← tweak in Inspector
var _velocity : Vector2 = Vector2.RIGHT        # always move right



func _physics_process(delta: float) -> void:
	position += _velocity * speed_px_per_sec * delta
