class_name HungerLabel   
extends Label

@onready var hunger_progress_bar: ProgressBar = %HungerProgressBar
@onready var hunger_progress_label: Label = %HungerProgressLabel



func _ready() -> void: ## At ready, label will connect with Events Global to update hunger text displayed. 
	Events.hunger_changed_signal.connect(_on_hunger_changed)
	set_text("Hunger")
	var value = Globals.current_hunger
	hunger_progress_bar.set_value(value)
	var progress = int(value * 100)
	var progress_display = str(progress)
	hunger_progress_label.set_text(progress_display)


func _on_hunger_changed(value: float) -> void:
	set_text("Hunger")
	hunger_progress_bar.set_value(value)
	var progress = int(value * 100)
	var progress_display = str(progress)
	hunger_progress_label.set_text(progress_display)
