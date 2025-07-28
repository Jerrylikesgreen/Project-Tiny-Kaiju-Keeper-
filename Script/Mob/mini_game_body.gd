class_name MiniGameBody extends BaseBody

@export var flap_impulse : float = -250.0   # up‑kick (negative = up in 2‑D coordinates)
@export var gravity      : float = 900.0    # pixels/s² downward pull
@export var max_fall     : float = 1000.0   # cap the terminal speed
@onready var mini_sfx_3: MiniSFX = %mini_sfx3

@export var flap_x_boost  : float = 40.0     # → shove added each flap
@export var max_x_speed   : float = 150.0    # cap sideways speed (optional)
@export var _is_running : bool 

func _ready() -> void:
	Events.mini_game_started.connect(_on_start)

func _physics_process(delta: float) -> void:
	
	if _is_running:
		velocity.y = min(velocity.y + gravity * delta, max_fall)
	
		if Input.is_action_just_pressed("flap"):
			mini_sfx_3.set_stream(mini_sfx_3.flap)
			mini_sfx_3.play()
			velocity.y = flap_impulse
			velocity.x = clamp(velocity.x - flap_x_boost, -max_x_speed, max_x_speed)
			base_body_sprite.rotation_degrees = -20.0

	
		var target_rot := clampf(velocity.y * 0.1, -20.0, 90.0)
		base_body_sprite.rotation_degrees = lerpf(base_body_sprite.rotation_degrees, target_rot, 6.0 * delta)
		
		move_and_slide()    

func _on_start()->void:
	_is_running = true
	print(_is_running)
