class_name HappyLabel 
extends Label

@onready var happy_progress_bar: ProgressBar = %HappyProgressBar


func _ready() -> void: ## At ready, label will connect with Events Global to update happyness text displayed. 
	Events.happiness_changed.connect(_on_happiness_changed)


func _on_happiness_changed(h_tex: String, value: float) -> void: ## Triggered on happyness signal from Events. 
	set_text("Happiness") ## turns float:String for label. Will use float for progress bar. 
	happy_progress_bar.set_value(value)
	push_warning("set_text →", value)
