class_name HappyLabel 
extends Label

@onready var happy_progress_bar: ProgressBar = %HappyProgressBar
@onready var happy_progress_label: Label = %HappyProgressLabel


func _ready() -> void: ## At ready, label will connect with Events Global to update happyness text displayed. 
	Events.happiness_changed_signal.connect(_on_happiness_changed)
	set_text("Happiness") 


func _on_happiness_changed(value: float) -> void: 
	happy_progress_bar.set_value(value)
	var progress = int(value * 100)
	var progress_display = str(progress)
	happy_progress_label.set_text(progress_display)
