class_name HungerLabel   
extends Label

@onready var hunger_progress_bar: ProgressBar = $HungerProgressBar

func _ready() -> void: ## At ready, label will connect with Events Global to update hunger text displayed. 
	Events.hunger_changed.connect(_on_hunger_changed)

func _on_hunger_changed(h_tex: String, value: float) -> void:## Triggered on happyness signal from Events. 
	set_text("Hunger") ## For Lable. 
	hunger_progress_bar.set_value(value)
	print("Hunger set_text →", h_tex)
