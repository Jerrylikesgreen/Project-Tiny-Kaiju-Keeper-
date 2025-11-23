class_name WorldManager extends PanelContainer


const COOKIE = preload("res://Scenes/cookie.tscn")
@onready var sfx: AudioStreamPlayer = $SFX
const POOP = preload("uid://sjiy0fxc8ojc")

## Observer node for the World. Anything that is displayed inside the World will send signals here.
@onready var cookie_container: Node2D = %CookieContainer
@onready var poop_container: ItemList = %PoopContainer


var can_spawn_cookie: bool = false

func _ready() -> void:
	Events.poop_signal.connect(_on_poop)

func _on_poop(v:bool)->void:
	if v == false:
		return
	var poop: Poop = POOP.instantiate()
	poop_container.add_child(poop)


func _on_cookie_ate()->void:
	print("Signal Reached")
	sfx.play()
	if can_spawn_cookie == false:
		can_spawn_cookie = true
