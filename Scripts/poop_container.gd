class_name PoopContainer extends GridContainer
const POOP = preload("uid://sjiy0fxc8ojc")

func _ready() -> void:
	Events.poop_signal.connect(_on_poop_signal)
	
	
func _on_poop_signal(v:bool)->void:
	if v:
		var poop: PoopDisplay = POOP.instantiate()
		add_child(poop)
