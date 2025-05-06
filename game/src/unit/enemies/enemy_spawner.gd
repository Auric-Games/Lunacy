extends Node

@export var wave_one_count : int = 8
@export var unit_cap : int = 100

var _enemy_count: int = 0
var _wave_count: int = 0

@onready var _unit_ref: BaseUnit = get_parent().get_node("PlayerContainer/PlayerUnit")
@onready var _enemy_ref: PackedScene = preload("res://game/templates/unit/unit_enemy.tscn")
@onready var timer: Timer = Timer.new()
@onready var timer_two : Timer = Timer.new()

@onready var _enemy_buffer : Array[BaseUnit] = []
var _buffer_limit : int = 20

func _ready() -> void:
	# Set up timer
	add_child(timer)
	timer.wait_time = 10
	timer.one_shot = true
	timer.timeout.connect(do_wave)

	add_child(timer_two)
	timer_two.wait_time = 2
	timer_two.one_shot = true
	timer_two.timeout.connect(do_wave)
	timer_two.start()

func _process(delta: float) -> void:
	if _enemy_count <= 0 && timer_two.is_stopped() && timer.time_left >= 3:
		print ("Early Wave Timer Triggered")
		timer.stop()
		timer_two.start()
signal enemy_spawned()
func spawn_enemy() -> void:
	var enemy : EnemyUnit
	if _enemy_count >= unit_cap:
		if _enemy_buffer.size() >= _buffer_limit : return
		enemy = _enemy_ref.instantiate()
		add_child(enemy)
		enemy.enemy_died.connect(shrink_counter)
		_enemy_buffer.append(enemy)
	elif (!_enemy_buffer.is_empty()):
		enemy = _enemy_buffer.pop_back()
		enemy.enable_self()
		position_enemy(enemy)
		enemy.enable_self()
		_enemy_count += 1
	else:
		enemy = _enemy_ref.instantiate()
		add_child(enemy)
		position_enemy(enemy)
		enemy.enemy_died.connect(shrink_counter)
		enemy.enable_self()
		_enemy_count += 1
	
	enemy.max_hp = enemy.max_hp * get_mult()
	enemy.current_hp = enemy.max_hp
	enemy.move_speed = enemy.move_speed * get_mult()
	enemy.contact_damage = enemy.contact_damage * get_mult()

	enemy_spawned.emit(enemy)

func position_enemy(enemy : BaseUnit) -> void:
	var player_pos : Vector2 = _unit_ref.global_position
	var spawn_pos : Vector2 = Vector2.ZERO

	spawn_pos.x = player_pos.x + randf_range(-300, 300)
	spawn_pos.y = player_pos.y + randf_range(-300, 300)

	if spawn_pos.distance_to(player_pos) < 200:
		spawn_pos = spawn_pos.normalized() * 250 + player_pos

	enemy.global_position = spawn_pos

func do_wave() -> void :
	var spawn_count : int = wave_one_count + calculate_spawn_multiplier()
	print("spawn count: ", spawn_count)

	for i in range(spawn_count):
		spawn_enemy()
	_wave_count += 1
	timer.start()
	update_mult(get_mult() + 0.05)

func calculate_spawn_multiplier() -> int:
	return get_mult()*_wave_count/2

func get_mult() -> float :
	return get_parent().difficulty_mult

func update_mult(new_mult : float) -> void :
	get_parent().difficulty_mult = new_mult

signal enemy_died()
func shrink_counter() -> void :
	enemy_died.emit()
	_enemy_count -= 1
