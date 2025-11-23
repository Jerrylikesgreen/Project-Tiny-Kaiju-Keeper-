class_name FeedButton extends Button

@export var feed_rate: int = 30

var _can_eat:bool = false

func _ready()-> void:
	Events.can_feed.connect(_on_can_feed)

func _on_pressed() -> void:
	var cookies = Globals.get_cookie_count()
	print("Cookies before feed:", cookies)

	if cookies <= 0:
		Events.display_player_message("You don't have any cookies!")
		print("can't eat")
		return

	# Feed action
	var rate = 0.01 * feed_rate
	var new_value = Globals.current_hunger + rate
	Globals.set_current_hunger(new_value)

	Globals.set_cookie_count(cookies - 1)

	Events.sfx_trigger(SFX.Track.BLIP)
	print("eat, cookies now:", Globals.get_cookie_count())

		

func _on_can_feed(value:bool)->void:
	print("on can feed triggerd")
	_can_eat = value

func _on_trigger_can_feed(can_feed: bool) -> void:
	_can_eat = can_feed
	print("Feed - ", "Yes" if can_feed else "No")
