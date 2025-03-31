class_name BaseUnit extends CharacterBody2D

@onready var hurtBox : Area2D
@onready var collisionBox : CollisionShape2D

@export_category("Unit Stats")
@export var current_hp : int = 100 :
	set(value) :
		# print ("Current HP: ", value)
		current_hp = value
		hp_changed.emit()
@export var max_hp : int = 100 :
	set(value) :
		max_hp = value
		if (current_hp > max_hp) :
			current_hp = max_hp
@export var move_speed : float = 100 :
	set(value) :
		move_speed = value	


signal hp_changed

# Protected Vars
var _target_velocity : Vector2 = Vector2.ZERO :
	set(value) :
		_target_velocity = value
		update_velocity(_target_velocity)

func _physics_process(_delta : float) -> void :
	pass

func _load_data(data : Resource) -> void :
	pass



func update_velocity(new_velocity : Vector2, update_speed : float = move_speed / 1000) -> void :
	self.velocity = lerp(self.velocity, new_velocity, update_speed)
