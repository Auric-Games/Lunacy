extends PlayerState

@export var input_limit : int = 3
@export_range(0, 1) var time_slowdown : float = 0.3 :
	set(value) :
		time_slowdown = value;

var prev_state : String 
var input_string : String
var input_count : int

@export var move_dir : Vector2 = Vector2.ZERO
var last_dir = {}

signal fizzled()
signal combo_attempt(combo : String)
signal combo_input(input : int)
signal entered(toggle : bool)

func enter(_previous_state_path: String, _data := {}) -> void:
	print("entering skill mode")
	prev_state = _previous_state_path
	input_string = ""
	input_count = 0

	Engine.time_scale = time_slowdown

	can_attack = false;
	entered.emit(true)

func exit() -> void:
	Engine.time_scale = 1.0
	entered.emit(false)

func physics_update(delta : float) -> void:
	if Input.is_action_just_pressed('skill_mode') :
		if (input_count != 0) :
			print("processing combo" + input_string)
			combo_input.emit(0) 
			combo_attempt.emit(input_string)
		finished.emit(prev_state)
	elif Input.is_action_just_pressed('attack_one') :
		input_count += 1
		input_string += "L"
		combo_input.emit(1)
	elif Input.is_action_just_pressed('attack_two'):
		input_count += 1
		input_string += "R"
		combo_input.emit(2)
	
	if input_count >= input_limit :
		combo_attempt.emit(input_string)
		finished.emit(prev_state)

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
