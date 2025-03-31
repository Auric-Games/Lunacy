extends Camera2D

@export var INPUT_RADIUS : float = 100
@export var CAMERA_BOUND : float = 200 
@export var CAMERA_SPEED : float = 0.04 # 0 -> 1.0

var player_ref : PlayerUnit 
var internal_pos : Vector2



func _ready() -> void:
	player_ref = get_parent().get_node("PlayerUnit")
	position = player_ref.position

func _process(delta: float) -> void:
	pass

func follow_mouse() -> void :
	#move mouse to center between player and mouse
	var mouse_pos : Vector2 = get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player_ref.global_position
	var distance : float = mouse_delta.length()

	if (distance > INPUT_RADIUS) :
		var target : Vector2 = mouse_delta.normalized() * distance / 2 + player_ref.global_position
		
		move_to_pos(target)
	else :
		move_to_pos(player_ref.global_position)


func move_to_pos(target : Vector2, speed : float = CAMERA_SPEED) -> void :
	position = position.lerp(target, speed)
