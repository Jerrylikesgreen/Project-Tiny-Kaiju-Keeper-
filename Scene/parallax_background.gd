extends ParallaxBackground

@export var base_speed := 120.0      # should match pipe speed

func _process(delta):
	scroll_offset.x += base_speed * delta             # layer speed 1×
