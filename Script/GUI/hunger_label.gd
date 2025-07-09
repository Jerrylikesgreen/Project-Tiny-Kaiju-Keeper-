class_name HungerLabel   
extends Label

@onready var hunger_progress_bar: ProgressBar = %HungerProgressBar
@onready var hunger_progress_label: Label = %HungerProgressLabel



func _ready() -> void: ## At ready, label will connect with Events Global to update hunger text displayed. 
	Events.hunger_changed.connect(_on_hunger_changed)

func _on_hunger_changed(h_tex: String, value: float) -> void:## Triggered on happyness signal from Events. 
	set_text("Hunger") ## turns float:String for label. Will use float for progress bar. 
	hunger_progress_bar.set_value(value)
	var progress = int(value * 100)
	var progress_display = str(progress)
	hunger_progress_label.set_text(progress_display)
	push_warning("set_text →", value)
