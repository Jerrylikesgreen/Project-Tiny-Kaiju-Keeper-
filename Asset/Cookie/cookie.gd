class_name Cookie extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func feed()->void:
	animation_player.play("feed")
	print("feed")
