class_name HungerLabel   
extends Label

@onready var hunger_progress_bar: ProgressBar = $HungerProgressBar

func _ready() -> void: ## At ready, label will connect with Events Global to update hunger text displayed. 
	Events.hunger_changed.connect(_on_hunger_changed)

func _on_hunger_changed(h_tex: String, value: float) -> void:## Triggered on happyness signal from Events. 
	set_text("Hunger:" + h_tex) ## turns float:String for label. Will use float for progress bar. 
	hunger_progress_bar.set_value(value)
	print("set_text →", value)
