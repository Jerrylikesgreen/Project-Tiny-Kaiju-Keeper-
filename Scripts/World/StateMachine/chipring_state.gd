class_name ChirpingState extends StateMachine


signal chirp
signal chirp_state_ended


func run_chirping_state()-> void:
	PET_STATE = 1
	emit_signal("chirp")


func _on_sfx_finished() -> void:
	PET_STATE = 0
	emit_signal("chirp_state_ended")
