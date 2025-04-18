class_name DamageNumber extends Path2D

@export var lifetime : float = 1.0

var text : Label = Label.new()
var font : FontFile = preload("res://game/assets/common/fonts/Abaddon_Fonts_v1.2/Abaddon Bold.ttf")
var follow_node : PathFollow2D = PathFollow2D.new()

const DMG : int = 0
const HEAL : int = 1
const MANA : int = 2
const TEXT : int = 3

const TYPE : Array[int] = [DMG, HEAL, MANA, TEXT]

const DMG_CLR : Color = Color.RED
const HEAL_CLR : Color = Color.GREEN
const MANA_CLR : Color = Color.BLUE
var custom_color : Color = Color.WHITE

func _ready() -> void:
	text.add_theme_font_override("font", font)
	text.add_theme_font_size_override("font_size", 10)

	curve = Curve2D.new()
	curve.add_point(Vector2.ZERO)
	curve.add_point(Vector2(0, -40))
	curve.add_point(Vector2(0, -30))

	follow_node.rotates = false
	add_child(follow_node)
	follow_node.add_child(text)

	hide()

func display_number(type : int, val : String, pos : Vector2) -> void:
	position = pos + Vector2(0, -40)
	text.text = val
	
	match type:
		DMG:
			text.set("theme_override_colors/font_color", DMG_CLR)
		HEAL:
			text.set("theme_override_colors/font_color", HEAL_CLR)
		MANA:
			text.set("theme_override_colors/font_color", MANA_CLR)
		TEXT:
			text.set("theme_override_colors/font_color", custom_color)

	follow_node.progress_ratio = 0
	
	show()
	var tween := create_tween()
	tween.tween_property(follow_node, "progress_ratio", 1.0, lifetime).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	await( tween.finished )
	hide()
