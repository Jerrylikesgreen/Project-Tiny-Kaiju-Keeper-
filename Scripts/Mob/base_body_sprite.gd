class_name BaseBodySprite extends AnimatedSprite2D
@onready var animation_playerpet: AnimationPlayer = %AnimationPlayerpet
@onready var ev_visual_effect: CanvasModulate = $EvVisualEffect

const ADULT_GIGAZILLA = preload("res://Resources/Sprite/adult_gigazilla.tres")
const ADULT_MOTHLYN = preload("res://Resources/Sprite/adult_mothlyn.tres")
const EGG_1 = preload("res://Resources/Sprite/egg.tres")
const EGG_2 = preload("res://Resources/Sprite/egg_2.tres")
const HATCHLING = preload("res://Resources/Sprite/hatchling.tres")
const JUVENILE_GIGAZILLA = preload("res://Resources/Sprite/juvinial_gigazilla.tres")
const JUVENILE_MOTHLYN = preload("res://Resources/Sprite/juvinial_mothlyn.tres")

enum FrameSet { EGG_1, EGG_2, HATCHLING, JUV_GIGA, JUV_MOTH, ADULT_MOTH, ADULT_GIGA }
var frame_set: FrameSet = FrameSet.EGG_1
const STAGE_FRAMES := {
	FrameSet.EGG_1:           EGG_1,
	FrameSet.EGG_2:         EGG_2,
	FrameSet.HATCHLING:     HATCHLING,
	FrameSet.JUV_GIGA:      JUVENILE_GIGAZILLA,
	FrameSet.JUV_MOTH:      JUVENILE_MOTHLYN,
	FrameSet.ADULT_GIGA:    ADULT_GIGAZILLA,
	FrameSet.ADULT_MOTH:    ADULT_MOTHLYN,
	
}

func _ready() -> void:
	ev_visual_effect.ev_finished_signal.connect(_on_ev_finished_signal)
	Events.evolve_signal.connect(_evolution)
	sprite_frames = Globals.get_active_sprite()

func _on_ev_finished_signal() ->void:
	print("Signal")
	_set_frame(frame_set)


func _evolution(state:PetResource.PetGrowthState)->void:
	print("evelution call")
	match state:
		
		PetResource.PetGrowthState.HATCHLING:
			ev_visual_effect.play()
			frame_set = FrameSet.HATCHLING
			
			
			
			
			
		PetResource.PetGrowthState.JUVINIAL:
			var body: PetBody = get_parent()
			if body.pet_resource.ev_line == body.pet_resource.EvLine.GODZILA:
				ev_visual_effect.play()
				frame_set = FrameSet.JUV_GIGA

			else:
				frame_set = FrameSet.JUV_MOTH
				
		PetResource.PetGrowthState.ADULT:
			var body: PetBody = get_parent()
			if body.pet_resource.ev_line == body.pet_resource.EvLine.GODZILA:
				frame_set = FrameSet.ADULT_GIGA
			else:
				frame_set = FrameSet.ADULT_MOTH


func _set_frame(new_frame: FrameSet) -> void:
	print(new_frame)
	var new_frames: SpriteFrames = STAGE_FRAMES[new_frame]
	var current_anim: String = animation
	sprite_frames = new_frames
	play(current_anim)
