extends Node2D

var player_unit : PlayerUnit
var player_camera : Camera2D
var game_timer : Timer

var total_time : int = 0

signal time_changed

func _ready() -> void:
	initialize_player()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

	game_timer = Timer.new()
	game_timer.wait_time = 1
	game_timer.one_shot = false
	game_timer.autostart = true
	add_child(game_timer)

	game_timer.timeout.connect(update_time)

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_cancel")) :
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func initialize_player() -> void :
	player_unit = get_node("PlayerContainer/PlayerUnit")
	player_unit.camera_ref = get_node("PlayerContainer/Camera")

func update_time() -> void :
	total_time += 1
	time_changed.emit(total_time)
