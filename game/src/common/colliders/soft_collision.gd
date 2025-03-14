class_name SoftCollision extends Area2D

@export var collision_shape : CollisionShape2D
@export var push_force : float = 200

func is_colliding() -> bool:
	return get_overlapping_areas().size() > 0

func get_push_vector() -> Vector2:
	var push_vector = Vector2.ZERO
	if is_colliding() :
		for area in get_overlapping_areas() :
			push_vector += area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized()
	return push_vector

func _init() -> void:
	collision_shape = CollisionShape2D.new()
	collision_shape.owner = self
	add_child(collision_shape)

func _ready() -> void:
	collision_shape = CollisionShape2D.new()
	collision_shape.owner = self
	add_child(collision_shape)
