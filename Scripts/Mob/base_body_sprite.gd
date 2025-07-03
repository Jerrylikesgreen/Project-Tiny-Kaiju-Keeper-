class_name BaseBodySprite extends AnimatedSprite2D

const ADULT_GIGAZILLA = preload("res://Resources/adult_gigazilla.tres")
const ADULT_MOTHLYN = preload("res://Resources/adult_mothlyn.tres")
const EGG = preload("res://Resources/egg.tres")
const EGG_2 = preload("res://Resources/egg_2.tres")
const HATCHLING = preload("res://Resources/hatchling.tres")
const JUVINIAL_GIGAZILLA = preload("res://Resources/juvinial_gigazilla.tres")
const JUVINIAL_MOTHLYN = preload("res://Resources/juvinial_mothlyn.tres")

enum Stage { EGG, EGG_2, HATCHLING, JUV_GIGA, JUV_MOTH, ADULT_MOTH, ADULT_GIGA }

const STAGE_FRAMES := {
	Stage.EGG:           EGG,
	Stage.EGG_2:         EGG_2,
	Stage.HATCHLING:     HATCHLING,
	Stage.JUV_GIGA:      JUVINIAL_GIGAZILLA,
	Stage.JUV_MOTH:      JUVINIAL_MOTHLYN,
	Stage.ADULT_GIGA:    ADULT_GIGAZILLA,
	Stage.ADULT_MOTH:    ADULT_MOTHLYN,
	
}


func _ready() -> void:
	Events.change_pet_animation.connect(_on_signal)



func _on_signal(animation:String)-> void:
	play(animation)
	
func set_stage(stage: Stage) -> void:
	if not STAGE_FRAMES.has(stage):
		print("Unknown stage: %s" % stage)
		return

	var new_frames: SpriteFrames = STAGE_FRAMES[stage]

	sprite_frames = new_frames

	var current_anim = sprite_frames
	if new_frames.has_animation(current_anim):
		play(current_anim)
	else:
		play(new_frames.get_animation_names()[0])

	frame = 0
