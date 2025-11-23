class_name HygieneLabel   
extends Label


@onready var hygiene_progress_label: Label = $"../../Colomn2/HygieneProgressBar/HygieneProgressLabel"
@onready var hygiene_progress_bar: ProgressBar = %HygieneProgressBar

func _ready() -> void:
	Events.hygiene_changed_signal.connect(_on_hygiene_changed) 
	set_text("Hygiene")
	var value = Globals.current_hygiene
	hygiene_progress_bar.set_value(value)
	var progress = int(value * 100)
	var progress_display = str(progress)
	hygiene_progress_label.set_text(progress_display)


func _on_hygiene_changed(value: float) -> void: ## Triggered on happyness signal from Events. 
	hygiene_progress_bar.set_value(value)
	var progress = int(value * 100)
	var progress_display = str(progress)
	hygiene_progress_label.set_text(progress_display)
