extends PlayerState

@export var move_dir : Vector2 = Vector2.ZERO

var last_dir = {}

func _ready():
	can_attack = true
	can_move = true
	super()

func enter(previous_state_path: String, data := {}) -> void:
	pass


func physics_update(delta: float) -> void :
	move_dir = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down', 0.1)
	player._target_velocity = move_dir * player.move_speed

	player.move_and_slide()

	match get_cardinal(move_dir) :
		NORTH:
			player.sprite_ref.play("run_north")
			last_dir["animation"] = NORTH
		EAST:
			if (player.sprite_ref.flip_h == true) : player.sprite_ref.flip_h = false
			player.sprite_ref.play("run_east")
			last_dir["animation"] = EAST
		SOUTH:
			player.sprite_ref.play("run_south")
			last_dir["animation"] = SOUTH
		WEST:
			if (player.sprite_ref.flip_h == false) : player.sprite_ref.flip_h = true
			player.sprite_ref.play("run_east")
			last_dir["animation"] = WEST
		-1:
			if (is_equal_approx(move_dir.x, 0) && is_equal_approx(move_dir.y, 0.0)) :
				finished.emit("Idle", last_dir) 
		_:
			printerr("how did you manage to get an integer not 0-3 in move_dir")

		
