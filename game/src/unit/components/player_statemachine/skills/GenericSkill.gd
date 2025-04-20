class_name PlayerSkill extends Node 

@export var template_node : PackedScene
@export var combo_string : String = "X"

@export var cooldown : float = 5.0
@export var mana_penalty : int = 5

var mana_modifier : int = 0

@onready var timer : Timer
@onready var player : PlayerUnit = get_parent().get_parent()

signal no_mana

func reset_mana() -> void :
	mana_modifier = 0

func _ready() -> void:
	await owner.ready

	timer = Timer.new()
	timer.wait_time = 3.0
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(reset_mana)

func start() -> void : 
	if player.current_mp > mana_cost + mana_modifier :
		player.current_mp -= mana_cost + mana_modifier
		mana_modifier += mana_penalty
		timer.start()

		do_skill()
	else :
		no_mana.emit()

func do_skill() -> void :
	pass

func _exit_tree() -> void:
	timer.free()