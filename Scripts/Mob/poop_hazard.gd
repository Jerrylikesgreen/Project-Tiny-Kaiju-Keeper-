class_name PoopHazard
extends Area2D

@export var speed_px_per_sec : float  = 200.0
@export var move_dir         : Vector2 = Vector2.RIGHT   # ← now moves right
@export var despawn_x        : float   = 1000.0          # right‑side despawn
@export var time_to_live     : float   = 5.0


# Called only when the node is first instanced.
func _ready() -> void:
	if not is_connected("body_entered", _on_body_entered):
		body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	position += move_dir.normalized() * speed_px_per_sec * delta
	if position.x > despawn_x:          #  ▶  compare “>” instead of “<”
		_deactivate()

func reactivate(world_pos: Vector2) -> void:
	global_position = world_pos
	visible         = true
	monitoring      = true
	set_physics_process(true)
	await get_tree().create_timer(time_to_live).timeout
	_deactivate()

func _on_body_entered(_body: Node2D) -> void:
	Events.mini_game_hazard_trigger("Poop")
	_deactivate()

func _deactivate() -> void:
	visible    = false
	monitoring = false
	set_physics_process(false)
	if get_parent():
		get_parent().call_deferred("remove_child", self)
