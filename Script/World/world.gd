class_name WorldManager extends PanelContainer


const POOP = preload("res://Scene/poop.tscn")
const COOKIE = preload("res://Scene/cookie.tscn")
@onready var sfx: AudioStreamPlayer = $SFX

## Observer node for the World. Anything that is displayed inside the World will send signals here.
@onready var cookie_container: Node2D = %CookieContainer
@onready var poop_container: Node2D = %PoopContainer


var can_spawn_cookie: bool = true

func _ready() -> void:
	Events.poop.connect(_on_poop)
	Events.mini_game_ended.connect(_on_mini_game_ended)

func _on_feed_pressed() -> void:
	if can_spawn_cookie:
		var cookie = COOKIE.instantiate()
		cookie_container.add_child(cookie)
		cookie.cookie_ate.connect(_on_cookie_ate)
		can_spawn_cookie = false

		print("Yes")
	else: 
		print("No")
		return


func _on_cookie_ate():
	print("Signal Reached")
	sfx.play()
	if can_spawn_cookie == false:
		can_spawn_cookie = true

func _on_poop(value:bool):
	if value == true:
		var poop = POOP.instantiate()
		poop_container.add_child(poop)
	else: 
		pass


func _on_mini_game_ended()->void:
	
	pass
