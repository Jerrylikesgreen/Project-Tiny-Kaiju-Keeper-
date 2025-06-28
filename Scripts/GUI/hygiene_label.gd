class_name HygieneLabel   ## TODO - Create a progress bar. 
extends Label

func _ready() -> void:
	Events.hygiene_changed.connect(_on_hygiene_changed) ## At ready, label will connect with Events Global to update hygiene text displayed. 

func _on_hygiene_changed(h_text: String, value: float) -> void: ## Triggered on happyness signal from Events. 
	set_text(h_text) ## turns float:String for label. Will use float for progress bar. 
	print("set_text →", value)
