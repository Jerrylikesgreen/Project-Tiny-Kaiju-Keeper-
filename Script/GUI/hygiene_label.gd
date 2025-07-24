class_name HygieneLabel   
extends Label


@onready var hygiene_progress_label: Label = $"../../Colomn2/HygieneProgressBar/HygieneProgressLabel"
@onready var hygiene_progress_bar: ProgressBar = %HygieneProgressBar

func _ready() -> void:
	Events.hygiene_changed.connect(_on_hygiene_changed) ## At ready, label will connect with Events Global to update hygiene text displayed. 

func _on_hygiene_changed(_h_text: String, value: float) -> void: ## Triggered on happyness signal from Events. 
	set_text("Hygiene") ## turns float:String for label. Will use float for progress bar.  
	hygiene_progress_bar.set_value(value)
	var progress = int(value * 100)
	var progress_display = str(progress)
	hygiene_progress_label.set_text(progress_display)
