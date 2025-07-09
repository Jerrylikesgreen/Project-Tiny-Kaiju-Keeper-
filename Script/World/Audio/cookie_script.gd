class_name Cookie extends AnimatedSprite2D
@onready var sfx: AudioStreamPlayer = $SFX


signal cookie_ate

func _ready() -> void:
	_run_cookie()

func _run_cookie():
	play()
	sfx.play()



func _on_animation_looped() -> void:
	emit_signal("cookie_ate")
	queue_free()
	print("Looped")
	pass # Replace with function body.
