class_name CookieContainer extends Node2D

@onready var cookie: Cookie = $Cookie


func _ready() -> void:
	Events.feed_signal.connect(_on_feed_signal)

func _on_feed_signal()->void:
	cookie.feed()
	print("feed received")
