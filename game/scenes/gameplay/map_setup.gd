extends Node2D

var player_unit : PlayerUnit
var player_camera : Camera2D

func _ready() -> void:
	initialize_player()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_cancel")) :
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func initialize_player() -> void :
	player_unit = get_node("PlayerContainer/PlayerUnit")
	player_unit.camera_ref = get_node("PlayerContainer/Camera")
