class_name AI extends StateMachine

func _init() -> void:
	pass

func _ready() -> void :
	pass

func move_to_pos(target_pos : Vector2, delta : float = 1/60	) -> void :
	owner.position = owner.position.lerp(target_pos, delta)