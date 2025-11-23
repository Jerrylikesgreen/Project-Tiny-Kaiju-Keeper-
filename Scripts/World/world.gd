class_name WorldManager extends PanelContainer


const POOP = preload("res://Scenes/poop.tscn")
const COOKIE = preload("res://Scenes/cookie.tscn")
@onready var sfx: AudioStreamPlayer = $SFX

## Observer node for the World. Anything that is displayed inside the World will send signals here.
@onready var cookie_container: Node2D = %CookieContainer
@onready var poop_container: Node2D = %PoopContainer


var can_spawn_cookie: bool = false



func _on_cookie_ate():
	print("Signal Reached")
	sfx.play()
	if can_spawn_cookie == false:
		can_spawn_cookie = true
