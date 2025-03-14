extends AI

@onready var player_ref : BaseUnit

func chase_target(target : BaseUnit = player_ref) -> void :
	move_to_pos(target.position)

