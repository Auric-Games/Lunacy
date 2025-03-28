class_name SoftCollision extends Area2D

@export var collision_shape : CollisionShape2D :
	set(value) :
		add_child(value)
		value.owner = self
		collision_shape = value

@export var push_force : float = 200

func is_colliding() -> bool:
	return get_overlapping_areas().size() > 0

func get_push_vector() -> Vector2:
	var push_vector = Vector2.ZERO
	if is_colliding() :
		for area in get_overlapping_areas() :
			push_vector += area.global_position.direction_to(global_position) * 10
		push_vector = push_vector.normalized()
	return push_vector

func _init() -> void:
	set_collision_layer_value(32,true)
	if (get_child_count() == 0) :
		collision_shape = CollisionShape2D.new()
		collision_shape.owner = self
	else :
		collision_shape = get_child(0)
	#collision_shape = CollisionShape2D.new()
	#add_child(collision_shape)

func _ready() -> void:
	if (get_child_count() == 0) :
		collision_shape = CollisionShape2D.new()
		collision_shape.owner = self
	else :
		collision_shape = get_child(0)
	#collision_shape = CollisionShape2D.new()
	#add_child(collision_shape)
