class_name PlayerSkill extends Node 

@export var template_node : PackedScene
@export var combo_string : String = "X"

@export var cooldown : float = 5.0
@export var mana_penalty : int = 5

var mana_modifier : int = 0

@onready var timer : Timer
@onready var player : PlayerUnit = get_parent().get_parent()
var tween : Tween = create_tween()


func reset_mana() -> void :
	mana_modifier = 0

func reset_tween() -> void :
	tween.kill()
	tween = create_tween()

func _ready() -> void:
	await owner.ready

	timer = Timer.new()
	timer.wait_time = 3.0
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(reset_mana)

func _exit_tree() -> void:
	timer.free()