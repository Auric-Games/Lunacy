class_name EnemyUnit extends NPCUnit

@onready var SoftCollider : SoftCollision = $SoftCollision

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func chase_player(delta : float) -> void:
	if (player == null) : printerr("Player not found")
	var move_dir = (player.global_position - global_position).normalized()
	_target_velocity = move_dir * move_speed
	if (SoftCollider.is_colliding()) :
		_target_velocity += SoftCollider.get_push_vector() * SoftCollider.push_force
	move_and_slide()

func _physics_process(delta : float):
	chase_player(delta)
