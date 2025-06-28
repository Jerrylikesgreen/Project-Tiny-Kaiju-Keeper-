class_name HappyLabel ## TODO - Create a progress bar. 
extends Label

func _ready() -> void: ## At ready, label will connect with Events Global to update happyness text displayed. 
	Events.happiness_changed.connect(_on_happiness_changed)


func _on_happiness_changed(h_tex: String, value: float) -> void: ## Triggered on happyness signal from Events. 
	set_text(h_tex) ## turns float:String for label. Will use float for progress bar. 
	push_warning("set_text →", value)


	
