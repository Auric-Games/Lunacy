extends BulletUnit
class_name PlayerUnit

# Behavior
@onready var movement : = $ComponentContainer/MovementComponent
@onready var input : = $ComponentContainer/InputComponent

# Nodes
@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D

func _init() -> void:
	speed = 200

func _physics_process(delta: float) -> void:
	var move_dir = input.get_movement_vector()
	movement.target_velocity = move_dir * speed
	if (!move_dir.is_zero_approx() && velocity.is_zero_approx()) :
		print("sprinting")
		movement.try_sprint(delta)
	movement.update_velocity(delta)

	move_and_slide()

func _ready() -> void:
	animationPlayer.play("idle")
