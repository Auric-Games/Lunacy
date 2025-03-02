extends Node

var owner_reference : BulletUnit

var target_velocity : Vector2 = Vector2(0,0) :
	set(value):
		#print(value)
		target_velocity = value
func try_sprint(delta : float ) -> void :
	owner_reference.velocity = lerp(
		owner_reference.velocity, 
		target_velocity.normalized() * owner_reference.sprint_speed,
		20* delta
	)

func update_velocity(delta : float, update_speed : float = 10) -> void :
	#print(str(owner_reference.velocity) + " to " + str(target_velocity))\
	owner_reference.velocity = lerp(owner_reference.velocity, target_velocity, update_speed*delta)

func _init() -> void :
	pass

func _ready() -> void :
	#if (get_parent() is ComponentList) :
		#if (!get_parent().get_parent() is BulletUnit) :
			owner_reference = get_parent().get_parent()
		#else : push_error("ERROR: MovementComponent is assigned to " + get_parent().get_parent().name + "\nmust be assigned to type \"BulletUnit\"")
	#else : push_error("WARNING: MovementComponent is assigned to " + get_parent().name+ "\nmust be assigned to type \"ComponentList\"")
