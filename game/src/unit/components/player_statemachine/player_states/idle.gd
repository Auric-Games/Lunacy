extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player._target_velocity = Vector2.ZERO
	if (data.is_empty()) : player.sprite_ref.play("idle_south")
	else : match (data["animation"]) :
		NORTH:
			print(data["animation"])
			player.sprite_ref.play("idle_north")
		EAST:
			if (player.sprite_ref.flip_h == true) : player.sprite_ref.flip_h = false
			player.sprite_ref.play("idle_east")
		SOUTH:
			player.sprite_ref.play("idle_south")
		WEST:
			if (player.sprite_ref.flip_h == false) : player.sprite_ref.flip_h = true
			player.sprite_ref.play("idle_east")
		_:
			printerr("how did you manage to get an integer not 0-3 in move_dir")

func physics_update(delta: float) -> void :
	if can_move && Input.get_vector('move_left', 'move_right', 'move_up', 'move_down', 0.1) != Vector2.ZERO :
		finished.emit("Run")
