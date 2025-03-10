class_name PlayerState extends State

@export var can_attack : bool = false
@export var can_move : bool =  true

@onready var player : PlayerUnit
@onready var weapon : Node2D

const NORTH : int = 0
const EAST : int = 1
const SOUTH : int = 2
const WEST : int = 3
const DIR : Array[int] = [NORTH, EAST, SOUTH, WEST]

func get_cardinal(direction : Vector2) -> int :
	if (abs(direction).x > abs(direction).y) :
		if direction.x > 0 :
			return EAST
		else :
			return WEST
	elif (abs(direction).x < abs(direction).y) :
		if direction.y > 0 :
			return SOUTH
		else :
			return NORTH
	return -1

func _ready() -> void:
	await owner.ready
	player = owner as PlayerUnit
	print(player.name)
	weapon = owner.weapon_ref
	assert(player != null, "ERROR : PlayerStates can only be attached to type PlayerUnit")