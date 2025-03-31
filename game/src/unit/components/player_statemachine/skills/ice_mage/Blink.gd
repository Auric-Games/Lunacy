extends PlayerSkill

@export var max_range : float = 200
@export var colision_radius : float = 20

func _ready() -> void:
	super()
	combo_string = "RRR"
	template_node = preload("res://game/templates/attacks/telefrag/ice_telefrag.tscn")

func start() -> void :
	var mouse_pos : Vector2 = player.get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player.global_position
	var target : Vector2 = Vector2.ZERO

	if (mouse_pos.distance_to(player.global_position) > max_range) :
		target = mouse_delta.normalized() * max_range + player.global_position
	else :
		target = mouse_pos
	
	var tween : Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	player.get_node("HurtBox").get_node("Collider").disabled = true; #move all this logic into iframe logic
	player.get_node("HitBox").get_node("Collider").disabled = false;

	
	#play teleport animation
	tween.tween_property(player, "global_position", target, 0.5)
	await tween.finished
	template_node.instantiate().global_position = target

	player.get_node("HurtBox").get_node("Collider").disabled = false;
	player.get_node("HitBox").get_node("Collider").disabled = true;

func reset_mana() -> void :
	mana_modifier = 0
