extends PlayerSkill

@export var max_range : float = 200

func _ready() -> void:
	super()
	reset_tween()
	combo_string = "RRR"

func start() -> void :
	var mouse_pos : Vector2 = player.get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player.global_position
	var target : Vector2 = Vector2.ZERO

	if (mouse_pos.distance_to(player.global_position) > max_range) :
		target = mouse_delta.normalized() * max_range + player.global_position
	else :
		target = mouse_pos
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	player.get_node("HurtBox").get_node("Collider").disabled = true; #move all this logic into iframe logic
	player.get_node("HitBox").get_node("Collider").disabled = false;
	
	player.global_position = player.global_position.lerp(target, 1.0) # Smoothly transition to the target position for visual effect
	#tween.tween_property(player, "global_position", target, 0.5)

	player.get_node("HurtBox").get_node("Collider").disabled = false;
	player.get_node("HitBox").get_node("Collider").disabled = true;

	reset_tween()

func reset_mana() -> void :
	mana_modifier = 0
