extends Control
class_name PlayerMessage

@export var speed: float = 0.08
@export var min_width_pixels := 120
@export var min_height_pixels := 32

@onready var timer  : Timer          = %Timer          # unique nodes
@onready var panel  : PanelContainer = %PC
@onready var label: Label = %Label


var _queue: Array[String] = []
var _txt  := ""
var _idx  := 0
var _typing := false
var _count:int

# ─────────────────────────────────────────────
# INITIAL SET‑UP
# ─────────────────────────────────────────────
func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	Events.player_message.connect(_on_player_message)

func _on_player_message(msg: String) -> void:
	if _typing:
		_queue.push_front(msg)
	else:
		_start(msg)

func _start(msg: String) -> void:
	print("[_start] got msg =", msg)   # should show the text you expect
	_txt    = msg
	_idx    = 0
	_typing = true
	label.text = ""
	visible = true
	await _type()
	_typing = false
	timer.start()

func _type() -> void:
	while _idx < _txt.length():
		label.text += _txt[_idx]
		_idx += 1
		_grow_bubble()
		await get_tree().create_timer(speed).timeout

func _on_timeout() -> void:
	_count = _count + 1
	if _count > 2:
		Events.intro_ended()
	if _queue.is_empty():
		visible = false
	else:
		_start(_queue.pop_back())


# ─────────────────────────────────────────────
# RESIZE HELPER
# ─────────────────────────────────────────────
func _grow_bubble() -> void:
	var need := label.get_minimum_size()
	need.x = max(need.x, min_width_pixels)
	need.y = max(need.y, min_height_pixels)
	panel.size = need          # width/height only; origin stays fixed
