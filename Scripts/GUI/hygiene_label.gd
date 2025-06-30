class_name HygieneLabel   
extends Label

@onready var hygiene_progress_bar: ProgressBar = $HygieneProgressBar

func _ready() -> void:
	Events.hygiene_changed.connect(_on_hygiene_changed) ## At ready, label will connect with Events Global to update hygiene text displayed. 

func _on_hygiene_changed(h_text: String, value: float) -> void: ## Triggered on happyness signal from Events. 
	set_text("Hygiene:" + h_text) ## turns float:String for label. Will use float for progress bar. 
	hygiene_progress_bar.set_value(value)
	print("set_text →", value)
