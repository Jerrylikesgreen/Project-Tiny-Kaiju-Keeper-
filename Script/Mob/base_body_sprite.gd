class_name BaseBodySprite extends AnimatedSprite2D

const ADULT_GIGAZILLA = preload("res://Resource/Sprite/adult_gigazilla.tres")
const ADULT_MOTHLYN = preload("res://Resource/Sprite/adult_mothlyn.tres")
const EGG = preload("res://Resource/Sprite/egg.tres")
const EGG_2 = preload("res://Resource/Sprite/egg_2.tres")
const HATCHLING = preload("res://Resource/Sprite/hatchling.tres")
const JUVENILE_GIGAZILLA = preload("res://Resource/Sprite/juvinial_gigazilla.tres")
const JUVENILE_MOTHLYN = preload("res://Resource/Sprite/juvinial_mothlyn.tres")

enum Stage { EGG, EGG_2, HATCHLING, JUV_GIGA, JUV_MOTH, ADULT_MOTH, ADULT_GIGA }

const STAGE_FRAMES := {
	Stage.EGG:           EGG,
	Stage.EGG_2:         EGG_2,
	Stage.HATCHLING:     HATCHLING,
	Stage.JUV_GIGA:      JUVENILE_GIGAZILLA,
	Stage.JUV_MOTH:      JUVENILE_MOTHLYN,
	Stage.ADULT_GIGA:    ADULT_GIGAZILLA,
	Stage.ADULT_MOTH:    ADULT_MOTHLYN,
	
}

func _ready() -> void:
	Events.change_pet_animation.connect(_on_signal)
	set_stage(Globals.current_pet_stage)



func _on_signal(new_stage_: Stage) -> void:
	if Globals.current_game_state == Globals.GameState.MINI_1:
		return
	set_stage(new_stage_)
	
func set_stage(new_stage: Stage) -> void:
	if not STAGE_FRAMES.has(new_stage):
		push_warning("Unknown stage: %s" % new_stage)
		return

	var new_frames: SpriteFrames = STAGE_FRAMES[new_stage]
	var current_anim: String = animation
	Globals.current_pet_stage = new_stage

	sprite_frames = new_frames

	if sprite_frames.has_animation(current_anim):
		play(current_anim)
	else:
		var fallback := sprite_frames.get_animation_names()[0]
		play(fallback)

	frame = 0    
