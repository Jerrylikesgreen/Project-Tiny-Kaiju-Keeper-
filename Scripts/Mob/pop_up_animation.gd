class_name PopUpAnimation extends AnimationPlayer


func _on_animation_finished(anim_name: StringName) -> void:
	play("Bounce")
