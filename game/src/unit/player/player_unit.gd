class_name PlayerUnit extends BaseUnit

# Notes
# implement delta
@export var UnitData : Resource 

@onready var camera_ref : Camera2D = $Camera
@onready var sprite_ref : AnimatedSprite2D = $SpriteController
@onready var weapon_ref : Node2D = $WeaponContainer
#@onready var statemachine : StateMachine = $StateMachine

func _ready() -> void :
	if (UnitData != null) :
		_load_data(UnitData)
	

func _process(_delta: float) -> void :
#	handle_movement_input()
	handle_mouse_input()

func _load_data(data : Resource) -> void :
	super._load_data(data)
	pass

#func handle_movement_input() -> void :
#	var move_dir : Vector2 = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down', 0.1)
#	_target_velocity = move_dir * move_speed
#
#	move_and_slide()

func handle_mouse_input() -> void :
	# need an if statement checking for input type handling (controller or mouse+keyboard) to ignore mouse input until mouse+keybaord enabled
	# need to implement variable camera speed based on mouse distance from center of viewport

	const INPUT_RADIUS : float = 200
	const CAMERA_BOUND : float = 400 
	const CAMERA_SPEED : float = 0.02 # 0 -> 1.0

	var mouse_pos : Vector2 = get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - global_position

	if (mouse_delta.length() >= INPUT_RADIUS) :
		var normalized_bounds = mouse_delta.normalized() * CAMERA_BOUND
		var target_pos = clamp(mouse_delta, -normalized_bounds, normalized_bounds)

		camera_ref.position = camera_ref.position.lerp(target_pos, CAMERA_SPEED)
	else:
		camera_ref.position = camera_ref.position.lerp(Vector2.ZERO, CAMERA_SPEED)
