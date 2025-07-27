class_name PlayerMessage extends Label

@export var player_message: String = "Player Message"
@export var speed: float = 0.08  # Seconds per character

@onready var timer: Timer = %Timer

var _char_index: int = 0
var _is_typing: bool = false

func _ready():
	text = ""
	_char_index = 0
	Events.player_message.connect(_on_player_message)

func _start_typing() -> void:
	text = ""
	_char_index = 0
	_is_typing = true
	await _typing()
	_is_typing = false
	timer.start()

func _typing() -> void:
	while _char_index < player_message.length():
		text += player_message[_char_index]
		_char_index += 1
		await get_tree().create_timer(speed).timeout

func _on_timer_timeout() -> void:
	set_visible(false)

func _on_player_message(new_message:String)->void:
	if _is_typing:
		return
	player_message = new_message
	set_visible(true)
	_start_typing()
	
