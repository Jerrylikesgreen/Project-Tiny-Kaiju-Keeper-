class_name EvVisualEffect extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play():
	animation_player.play("EvFlash")
	pass
	
