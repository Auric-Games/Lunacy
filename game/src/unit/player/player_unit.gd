class_name PlayerUnit extends BaseUnit

# Notes
# implement delta
@export var UnitData : Resource 

@export var camera_ref : Camera2D
@onready var sprite_ref : AnimatedSprite2D = $SpriteController
@onready var weapon_ref : Node2D = $WeaponContainer
#@onready var statemachine : StateMachine = $StateMachine

signal player_died

func _ready() -> void :
	if (UnitData != null) :
		_load_data(UnitData)

func _physics_process(delta: float) -> void:
	camera_ref.follow_mouse()

func _load_data(data : Resource) -> void :
	super._load_data(data)
	pass
