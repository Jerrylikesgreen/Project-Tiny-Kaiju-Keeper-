class_name PopUp2Animation extends AnimationPlayer


func _on_animation_finished(anim_name: StringName) -> void:
	
	play("Bounce")
