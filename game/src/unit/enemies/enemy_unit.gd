class_name EnemyUnit extends NPCUnit

@export var team : int = 1 # 1 for enemies, 0 for players
@export var contact_damage : int = 5

@onready var SoftCollider : SoftCollision = $SoftCollision

@onready var player = get_tree().get_nodes_in_group("Player")[0]

var _players_in_hurtbox : Array[PlayerUnit] 

func chase_player(delta : float) -> void:
	if (player == null) : printerr("Player not found")
	var move_dir = (player.global_position - global_position).normalized()
	_target_velocity = move_dir * move_speed
	if (SoftCollider.is_colliding()) :
		_target_velocity += SoftCollider.get_push_vector() * SoftCollider.push_force
	move_and_slide()

func take_damage(damage : int) -> void:
	current_hp -= damage

func _ready() -> void:
	current_hp = max_hp

func _physics_process(delta : float):
	chase_player(delta)
	if !_players_in_hurtbox.is_empty() :
		for unit in _players_in_hurtbox :
			unit.take_damage(contact_damage)
	if (current_hp <= 0) :
		queue_free()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body is PlayerUnit:
		_players_in_hurtbox.append(body)
		#print ("Player entered hurtbox: ", body.name)


func _on_hurt_box_body_exited(body: Node2D) -> void:
	if body in _players_in_hurtbox :
		_players_in_hurtbox.erase(body)
		#print ("Player exited hurtbox: ", body.name)
