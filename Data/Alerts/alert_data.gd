class_name AlertData extends Resource

@export var msg: String         = ""
@export var payload: Variant    = null   ## extra info (e.g. amount, position)
@export var ttl_sec: float      = 0.0    ## time-to-live; 0 = forever
