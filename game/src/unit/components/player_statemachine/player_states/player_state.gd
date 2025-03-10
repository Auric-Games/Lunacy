class_name PlayerState extends State

@export var can_attack : bool = false
@export var can_move : bool =  true

@onready var player : PlayerUnit

const NORTH : int = 0
const EAST : int = 1
const SOUTH : int = 2
const WEST : int = 3
const DIR : Array[int] = [NORTH, EAST, SOUTH, WEST]

func _ready() -> void:
	await owner.ready
	player = owner as PlayerUnit
	assert(player != null, "ERROR : PlayerStates can only be attached to type PlayerUnit")