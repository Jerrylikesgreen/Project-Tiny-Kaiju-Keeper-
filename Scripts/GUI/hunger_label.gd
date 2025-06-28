class_name HungerLabel   ## TODO - Create a progress bar. 
extends Label

func _ready() -> void: ## At ready, label will connect with Events Global to update hunger text displayed. 
	Events.hunger_changed.connect(_on_hunger_changed)

func _on_hunger_changed(h_tex: String, value: float) -> void:## Triggered on happyness signal from Events. 
	set_text(h_tex) ## turns float:String for label. Will use float for progress bar. 
	print("set_text →", value)
