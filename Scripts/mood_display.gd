class_name MoodDisplay
extends PanelContainer

const StatusEnum = preload("uid://bsknb2ab5somj")


@onready var mood_label: RichTextLabel = $MoodLabel  # make sure the child node exists

# Emoticons for each mood
var MOOD_EMOTICONS := {
	StatusEnum.Status.POOR: ["T_T", "(ᗒᗣᗕ)՞", "(シ_ _)シ", "ᕙ(⇀‸↼‶)ᕗ", "╥﹏╥"],
	StatusEnum.Status.MID: [":|", ":-|", "(-_-)", "(•︵•)"],
	StatusEnum.Status.GOOD: ["٩(＾◡＾)۶", "（＾ω＾）", "(^_^)", "(◕‿◕)", "(ᵔ◡ᵔ)"],
	StatusEnum.Status.EXCELLENT: ["(´♡‿♡`)", ":-D", "(≧◡≦)", "(*^▽^*)", "o(>ω<)o"],
	StatusEnum.Status.UNKNOWN: [":/", ":?", "(•_•)"]
}

# Optional: colors for text
var MOOD_COLORS := {
	StatusEnum.Status.POOR: "#c0392b",
	StatusEnum.Status.MID: "#f39c12",
	StatusEnum.Status.GOOD: "#27ae60",
	StatusEnum.Status.EXCELLENT: "#2980b9",
	StatusEnum.Status.UNKNOWN: "#7f8c8d"
}

func _ready():
	randomize()  # ensures random selection changes each run

func mood(status: StatusEnum.Status) -> void:
	if not mood_label:
		return
	
	var emoticon = get_random_emoticon(status)
	var color = MOOD_COLORS.get(status, "#ffffff")
	
	mood_label.bbcode_enabled = true
	mood_label.clear()
	var bbcode = "[center]" + emoticon
	mood_label.append_text(bbcode)
	match status:
		StatusEnum.Status.EXCELLENT:
			Events.sfx_trigger(SFX.Track.CHIRP)
		StatusEnum.Status.GOOD:
			Events.sfx_trigger(SFX.Track.CHIRP)
		StatusEnum.Status.MID:
			Events.sfx_trigger(SFX.Track.FLAP)
		StatusEnum.Status.MID:
			Events.sfx_trigger(SFX.Track.ROAR)
	

func get_random_emoticon(status: StatusEnum.Status) -> String:
	if not MOOD_EMOTICONS.has(status):
		return ":/"
	var list = MOOD_EMOTICONS[status]
	return list[randi() % list.size()]
