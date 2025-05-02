extends Node

@export var _pool_size : int = 100

@onready var _pool_ref : Array[DamageNumber] = []
@onready var _iterator : int = 0
@onready var _unit_refs : Array[BaseUnit] = []
@onready var spawner_ref : Node = get_parent().get_node("Enemies") 

var buffer : Dictionary = {}
var last_display_time: Dictionary = {}
@export var display_cooldown: float = 0.2 

func _ready() -> void:
	var player_ref : PlayerUnit = get_parent().get_node("PlayerContainer/PlayerUnit")
	player_ref.hp_changed.connect(handle_hp)
	# player_ref.mp_changed.connect(handle_mp)
	player_ref.get_node("SkillController").fizzled.connect(handle_fizzle)
	player_ref.get_node("SkillController").no_mana.connect(handle_no_mana)

	await get_parent().get_node("Enemies").ready

	for unit in get_parent().get_node("Enemies").get_children():
		if !(unit is BaseUnit) :
			print("Not a BaseUnit: ", unit)
			continue
		_unit_refs.append(unit)
		unit.hp_changed.connect(handle_hp)
	

	for i in range(_pool_size):
		var number : DamageNumber = DamageNumber.new()
		
		_pool_ref.append(number)
		add_child(number)

func _process(delta: float) -> void:
	if buffer.is_empty():
		return

	var now := Time.get_ticks_msec() / 1000.0

	for unit in buffer.keys():
		if last_display_time.has(unit) and (now - last_display_time[unit] < display_cooldown):
			continue

		for type in buffer[unit].keys():
			display_number(type, str(buffer[unit][type]), unit.position)

		last_display_time[unit] = now 
		buffer.erase(unit)
	
func display_number(type : int, val : String, position : Vector2) -> void:
	if _iterator >= _pool_size:
		_iterator = 0
	_pool_ref[_iterator].display_number(type, val, position)
	_iterator += 1

func handle_hp(unit : BaseUnit, new_hp : int) -> void:
	var delt : int = new_hp - unit.current_hp
	if (delt > 0):
		add_to_buffer(unit, DamageNumber.HEAL, delt)
	elif (delt < 0):
		add_to_buffer(unit, DamageNumber.DMG, -delt)

# func handle_mp(unit : BaseUnit, new_mp : int) -> void:
# 	var delt : float = new_mp - unit.current_mp
# 	if (delt > 0):
# 		print("MP: ", delt)
# 		add_to_buffer(unit, DamageNumber.MANA, delt)

func handle_fizzle(unit : BaseUnit) -> void:
	add_to_buffer(unit, DamageNumber.TEXT, "Spell Fizzled")
	print("Spell Fizzled")

func handle_no_mana(unit : BaseUnit) -> void:
	add_to_buffer(unit, DamageNumber.TEXT, "Not Enough Mana")
	print("Not Enough Mana")

func add_to_buffer(unit : BaseUnit, type : int, val) -> void:
	if !buffer.has(unit):
		buffer[unit] = {}
	if !buffer[unit].has(type):
		if type == DamageNumber.TEXT:
			buffer[unit][type] = ""
		else:
			buffer[unit][type] = val
	buffer[unit][type] += val
