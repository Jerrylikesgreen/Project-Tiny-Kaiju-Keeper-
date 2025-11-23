class_name PlayerCamera extends Camera2D
## Base camera for player display. Will hold all camera related functions. 

var _trauma      : float = 0.0
var _decay_rate  : float = 1.0      # updated per shake call

# ——— public ———
func shake(intensity: float = 2.0, duration: float = 0.15) -> void:
	_trauma      = clamp(_trauma + intensity, 0.0, 15.0)   # bigger number → bigger offset
	_decay_rate  = 1.0 / max(duration, 0.001)              # lasts `duration` seconds
