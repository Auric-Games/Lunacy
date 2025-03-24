class_name EnemyUnit extends NPCUnit

@export var max_hp : int = 100

@onready var SoftCollider : SoftCollision = $SoftCollision

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func chase_player(delta : float) -> void:
	if (player == null) : printerr("Player not found")
	var move_dir = (player.global_position - global_position).normalized()
	_target_velocity = move_dir * move_speed
	if (SoftCollider.is_colliding()) :
		_target_velocity += SoftCollider.get_push_vector() * SoftCollider.push_force
	move_and_slide()

func take_damage(damage : int) -> void:
	current_hp -= damage
	print("Damaged: " + str(current_hp) + "/" + str(max_hp))
	if (current_hp <= 0) :
		queue_free()

func _ready() -> void:
	current_hp = max_hp

func _physics_process(delta : float):
	chase_player(delta)
