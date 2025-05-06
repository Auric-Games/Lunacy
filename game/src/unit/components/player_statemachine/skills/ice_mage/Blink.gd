extends PlayerSkill

@export var max_range : float = 225
@export var colision_radius : float = 20

var iframe_timer : Timer

func _ready() -> void:
	super()
	combo_string = "RRR"
	template_node = preload("res://game/templates/attacks/telefrag/ice_telefrag.tscn")

	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 4

	mana_cost = 10

func do_skill() -> void :
	var mouse_pos : Vector2 = player.get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player.global_position
	var target : Vector2 = Vector2.ZERO

	if (mouse_pos.distance_to(player.global_position) > max_range) :
		target = mouse_delta.normalized() * max_range + player.global_position
	else :
		target = mouse_pos
	
	var tween : Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	player.hurt_timer.start() #move all this logic into iframe logic
	#play teleport animation
	tween.tween_property(player, "global_position", target, 0.5)
	await tween.finished

func reset_mana() -> void :
	mana_modifier = 0
