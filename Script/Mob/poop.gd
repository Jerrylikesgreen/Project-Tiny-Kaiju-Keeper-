class_name Poop extends AnimatedSprite2D


@export var speed_px_per_sec : float = 200.0   # ← tweak in Inspector
var _velocity : Vector2 = Vector2.RIGHT        # always move right

var mini_game:bool = false

func _ready() -> void:
	Events.poop.connect(_on_poop)
	

func _on_poop(v:bool):
	if v == false:
		queue_free()
	else:
		pass
		

func _physics_process(delta: float) -> void:
	if mini_game:
		position += _velocity * speed_px_per_sec * delta
