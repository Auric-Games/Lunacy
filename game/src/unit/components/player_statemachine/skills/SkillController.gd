extends Node

@export var skill_list : Dictionary	= {}
@onready var skill_state_ref : PlayerState = owner.get_node("StateMachine/SkillMode")
var timer : Timer

@export var mana_penalty : int = 5
var mana_modifier : int = 0

signal fizzled
signal no_mana

func _ready():
	for skill_node: PlayerSkill in find_children("*", "PlayerSkill"):
		skill_list[skill_node.combo_string] = skill_node
		skill_node.no_mana.connect(pass_no_mana)

	skill_state_ref.combo_attempt.connect(process_combo)

	timer = Timer.new()
	timer.wait_time = 3.0
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(reset_mana)

func _exit_tree() -> void:
	timer.queue_free()

func physics_process(delta: float) -> void:
	pass

func process_combo(combo : String) -> void:
	print(skill_list)
	print("combo: " + combo)
	if skill_list.has(combo) :
		timer.start()
		print("casting skill: " + combo)
		skill_list[combo].start()
	else :
		mana_modifier += mana_penalty * 3
		timer.start()
		fizzled.emit(get_parent())

func pass_no_mana() -> void :
	no_mana.emit(get_parent())

func reset_mana() -> void :
	mana_modifier = 0
