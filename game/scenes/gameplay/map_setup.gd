extends Node2D

var player_unit : PlayerUnit
var player_camera : Camera2D

func _ready() -> void:
	initialize_player()

func initialize_player() -> void :
	player_unit = get_node("PlayerContainer/PlayerUnit")
	player_unit.camera_ref = get_node("PlayerContainer/Camera")
