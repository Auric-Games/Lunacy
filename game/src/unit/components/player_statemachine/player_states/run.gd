extends PlayerState

@export var move_dir : Vector2 = Vector2.ZERO

func enter(previous_state_path: String, data := {}) -> void:
	pass

func choose_animation(direct : Vector2) -> int :
	if (abs(direct).x > abs(direct).y) :
		if direct.x > 0 :
			return EAST
		else :
			return WEST
	else :
		if direct.y > 0 :
			return SOUTH
		else :
			return NORTH

func physics_update(delta: float) -> void :
	move_dir = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down', 0.1)
	player._target_velocity = move_dir * player.move_speed

	player.move_and_slide()

	var dir = choose_animation(move_dir)
	match dir :
		NORTH:
			player.sprite_ref.play("run_north")
		EAST:
			if (player.sprite_ref.flip_h == true) : player.sprite_ref.flip_h = false
			player.sprite_ref.play("run_east")
		SOUTH:
			player.sprite_ref.play("run_south")
		WEST:
			if (player.sprite_ref.flip_h == false) : player.sprite_ref.flip_h = true
			player.sprite_ref.play("run_east")
		_:
			printerr("how did you manage to get an integer not 0-3 in move_dir")
	if (move_dir == Vector2.ZERO) :
		var out = {"animation" : dir}
		finished.emit("Idle", out) 
		
