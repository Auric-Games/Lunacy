extends PlayerState

@export var input_limit : int = 5
@export_range(0, 1) var time_slowdown : float = 0.3 :
	set(value) :
		time_slowdown = value;

var prev_state : String 
var input_string : String
var input_count : int

signal fizzled()
signal combo_attempt(combo : String, prev_state : String)

func enter(_previous_state_path: String, _data := {}) -> void:
	print("entering skill mode")
	prev_state = _previous_state_path
	input_string = ""
	input_count = 0

	Engine.time_scale = time_slowdown

func exit() -> void:
	Engine.time_scale = 1.0

func physics_update(delta : float) -> void:
	if Input.is_action_just_pressed('skill_mode') :
		if (input_count != 0) :
			print("processing combo" + input_string) 
			combo_attempt.emit(input_string, )
		finished.emit(prev_state)
	elif Input.is_action_just_pressed('attack_one') :
		input_count += 1
		input_string += "L"
		print(input_string)
	elif Input.is_action_just_pressed('attack_two'):
		input_count += 1
		input_string += "R"
		print(input_string)
	
	if input_count >= input_limit :
		fizzled.emit()
		finished.emit(prev_state)
