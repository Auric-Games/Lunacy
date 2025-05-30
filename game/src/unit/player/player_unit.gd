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
@onready var hurt_timer : Timer = $TimerManager/HurtTimer
@onready var attack_cooldown_timer : Timer = $TimerManager/AttackTimer
@onready var attack_combo_timer : Timer = $TimerManager/AttackComboTimer

#@onready var statemachine : StateMachine = $StateMachine

@export var max_mp : int = 200 :
	set(value) :
		max_mp = value
@export var current_mp : float = 200 :
	set(value) :
		mp_changed.emit(self, value)
		current_mp = value

@export var mana_regen : int = 15 : # per second
	set(value) :
		mana_regen = value
		true_mana_regen = float(value) / 60

var true_mana_regen : float = float(mana_regen) / 60

signal player_died
signal mp_changed

var frame_counter = 0 : # will not exceed 10s
	set(value) :
		frame_counter = value % 600

func _ready() -> void :
	if (UnitData != null) :
		_load_data(UnitData)
	timer_setup()

func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed('attack_one')) :
		print("attack one pressed")
		handle_basic_attack()
	camera_ref.follow_mouse()
	if current_mp < max_mp :
		regenerate_mp()
	frame_counter += 1

var template_node = preload("res://game/templates/attacks/bullet/bullet_temp.tscn")
var attack_counter = 0

func reset_attack_combo() -> void :
	attack_counter = 0


func handle_basic_attack() -> void :
	if ($StateMachine.state.name != "SkillMode" && attack_cooldown_timer.is_stopped()) :
		if (attack_counter < 2) :
			attack_counter += 1
			attack_cooldown_timer.start()
			attack_combo_timer.start()
			spawn_bullet()
		else :
			attack_counter = 0
			attack_combo_timer.stop()
			attack_cooldown_timer.start()
			spawn_bullet(15, 8, 30)
		
func spawn_bullet(size : int = 10, vel : float = 6, damage : int = 20)	-> void :
	var mouse_pos : Vector2 = get_global_mouse_position()
	var bullet = template_node.instantiate()

	bullet.position = global_position + (20 * (mouse_pos - global_position).normalized())
	bullet.scale = Vector2(size, size)
	bullet.speed = vel

	bullet.direction = (mouse_pos - global_position).normalized()
	bullet.rotate(bullet.direction.angle())
	get_tree().current_scene.call_deferred("add_child", bullet)	

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

func regenerate_mp() -> void :
	current_mp += true_mana_regen
	current_mp = clamp(current_mp, 0, max_mp)

func timer_setup() -> void :
	attack_cooldown_timer.wait_time = 0.5
	attack_cooldown_timer.one_shot = true
	
	attack_combo_timer.wait_time = 1
	attack_combo_timer.one_shot = true
	attack_combo_timer.timeout.connect(reset_attack_combo)

func _exit_tree() -> void:
	pass
