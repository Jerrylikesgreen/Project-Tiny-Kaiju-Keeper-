class_name PoopHazard extends Area2D


@export var speed_px_per_sec : float  = 200.0
@export var move_dir         : Vector2 = Vector2.RIGHT
@export var time_to_live     : float   = 5.0       # auto‑cleanup


func _ready() -> void:
	# vanish after N seconds
	get_tree().create_timer(time_to_live) \
			 .connect("timeout", self.queue_free)

func _physics_process(delta: float) -> void:
	position += move_dir.normalized() * speed_px_per_sec * delta

func _on_body_entered(body: Node2D) -> void:
	Events.mini_game_hazard_trigger("Poop")
	_deactivate()

func _deactivate() -> void:
	monitoring       = false          # Area2D stops detecting
	visible          = false          # hide sprite
	if get_parent():                  # detach from scene so physics sleeps
		get_parent().call_deferred("remove_child", self)
