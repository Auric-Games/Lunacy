class_name PlayerUnit extends BaseUnit

# Notes
# implement delta
@export var UnitData : Resource 

<<<<<<< HEAD
signal mp_changed

@export var max_map : int = 100
@export var current_mp : int = 100 :
	set(value) :
		current_mp = value
		mp_changed.emit()

@onready var camera_ref : Camera2D = $Camera
@onready var sprite_ref : AnimatedSprite2D = $SpriteController
@onready var weapon_ref : Node2D = $WeaponContainer
@onready var statemachine : StateMachine = $StateMachine
=======
@export var camera_ref : Camera2D
@onready var sprite_ref : AnimatedSprite2D = $SpriteController
@onready var weapon_ref : Node2D = $WeaponContainer
@onready var hurt_timer : Timer = $HurtTimer

#@onready var statemachine : StateMachine = $StateMachine

signal player_died
<<<<<<< HEAD
>>>>>>> parent of 26fa6eb (a lot)
=======
>>>>>>> parent of 26fa6eb (a lot)

func _ready() -> void :
	if (UnitData != null) :
		_load_data(UnitData)
<<<<<<< HEAD
	
func _process(_delta: float) -> void :
	#handle_mouse_input()
	pass
=======
	print (hurt_timer.name)

func _physics_process(delta: float) -> void:
	camera_ref.follow_mouse()
<<<<<<< HEAD
>>>>>>> parent of 26fa6eb (a lot)
=======
>>>>>>> parent of 26fa6eb (a lot)

func _load_data(data : Resource) -> void :
	super._load_data(data)
	pass

<<<<<<< HEAD
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

var _atk_counter : int = 0
func do_attack() -> void :
	if statemachine.state.can_attack :
		match _atk_counter :
			0 :
				pass 
			_ :	
				print("ERROR : UNEXPECTED NORMAL ATTACK COUNT DETECTED")
		if (_atk_counter >= 3) :
			_atk_counter = 0
		else :
			_atk_counter+=1
=======
func take_damage(value : int) -> void :
	if hurt_timer.is_stopped() :
		hurt_timer.start()
		sprite_ref.play("hurt")
		current_hp -= value
	if (current_hp <= 0) :
		$CollisionShape2D.disabled = true
		player_died.emit("Dead")
		print("Player Died")
	# run death script / destructor
<<<<<<< HEAD
>>>>>>> parent of 26fa6eb (a lot)
=======
>>>>>>> parent of 26fa6eb (a lot)
