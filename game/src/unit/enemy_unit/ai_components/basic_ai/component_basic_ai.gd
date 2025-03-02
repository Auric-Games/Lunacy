extends Node

@onready var player_ref : = get_tree().root.get_child(0).get_node("PlayerUnit")
var move_ref : Node 
var owner_ref : BulletUnit

func _ready() -> void :
	owner_ref = get_parent().get_parent()
	move_ref = owner_ref.get_node("ComponentContainer").get_node("MovementComponent")

func move_to_player(delta : float, update_spd : float = 10) -> void :
	move_to_pos(player_ref.position, delta, update_spd)

func move_to_pos(pos : Vector2, delta : float, update_spd : float = 10) -> void :
	var direction : Vector2 = owner_ref.global_position.direction_to(pos)
	move_ref.target_velocity = direction * owner_ref.speed
	move_ref.update_velocity(delta, update_spd)

	owner_ref.move_and_slide()
