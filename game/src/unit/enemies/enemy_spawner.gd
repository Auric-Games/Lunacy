extends Node

@export var _pool_size: int = 20
@export var _enemy_count: int = 0
@export var enabled_enemies: Dictionary = {}
@export var disabled_enemies: Array[EnemyUnit] = []

@onready var _unit_ref: BaseUnit = get_parent().get_node("PlayerContainer/PlayerUnit")
@onready var _enemy_ref: PackedScene = preload("res://game/templates/unit/unit_enemy.tscn")
@onready var timer: Timer = Timer.new()

func _ready() -> void:
	# Prepopulate enemy pool
	for i in range(_pool_size):
		var enemy: EnemyUnit = _enemy_ref.instantiate() as EnemyUnit
		disabled_enemies.append(enemy)
		add_child(enemy)
		enemy.disable_self()

	# Set up timer
	add_child(timer)
	timer.wait_time = 20
	timer.one_shot = true
	timer.timeout.connect(do_wave)
	timer.start()

func remove_enemy(enemy: EnemyUnit) -> void:
	if enemy in enabled_enemies:
		disabled_enemies.append(enabled_enemies[enemy])
		enabled_enemies.erase(enemy)
		enemy.disable_self()
		_enemy_count -= 1

func spawn_enemy() -> void:
	if disabled_enemies.size() == 0:
		return

	var enemy: EnemyUnit = disabled_enemies.pop_back() as EnemyUnit
	enabled_enemies[enemy] = enemy
	_enemy_count += 1

	var pot_pos := Vector2(
		_unit_ref.position.x + randf_range(-300, 300),
		_unit_ref.position.y + randf_range(-300, 300)
	)

	if pot_pos.distance_to(_unit_ref.position) < 200:
		enemy.position = pot_pos.normalized() * 200 + _unit_ref.position
	else:
		enemy.position = pot_pos

	enemy.enable_self()

func do_wave() -> void:

	var min_spawn := 3
	var max_spawn := _pool_size - _enemy_count
	if max_spawn <= 0:
		return

	var wave_size := rng.bell_curve(min_spawn, max_spawn)
	
	for i in range(wave_size):
		spawn_enemy()
		if _enemy_count >= _pool_size:
			break

	timer.start()
