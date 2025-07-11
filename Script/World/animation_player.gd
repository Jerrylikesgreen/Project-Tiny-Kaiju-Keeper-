extends AnimationPlayer


func _on_animation_finished(anim_name: StringName) -> void:
	set_current_animation("Loop")
