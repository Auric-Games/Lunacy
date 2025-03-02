extends Node

func get_movement_vector() -> Vector2 :
	#var temp : Vector2 = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down', 0.1)
	#print("INPUT VECTOR: " + str(temp))
	return Input.get_vector('move_left', 'move_right', 'move_up', 'move_down', 0.1)
	#return temp

func get_aim_vector() -> Vector2 :
	return Input.get_vector('aim_left', 'aim_right', 'aim_up', 'aim_down', 0.1)

func try_dash() -> bool:
	return Input.is_action_pressed('dash')
