extends CanvasModulate

signal ev_finished_signal

@onready var ev_visual_effect: AnimationPlayer = %"Ev Visual Effect"


func ev_finished()->void:
	emit_signal("ev_finished_signal")

func play()->void:
	ev_visual_effect.play()
