extends PlayerSkill

@export var limit : int = 10
@export var max_hp : int = 40
@export var max_range : float = 100

var count : int = 0

@export var instance_queue : Array

func _ready() -> void:
	super()
	template_node = preload("res://game/templates/skills/player_skills/IceWall.tscn")

	combo_string = "LLR"
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 4

	mana_cost = 20

func start() -> void :
	if player.current_mp > mana_cost + mana_modifier :
		player.current_mp -= mana_cost + mana_modifier
		mana_modifier += mana_penalty
		timer.start()

		do_skill()



func do_skill() -> void :
	var mouse_pos : Vector2 = player.get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player.global_position
	var target : Vector2 = Vector2.ZERO
	if (mouse_pos.distance_to(player.global_position) > max_range) :
		target = mouse_delta.normalized() * max_range + player.global_position
	else :
		target = mouse_pos

	var wall = template_node.instantiate()
	get_tree().current_scene.call_deferred("add_child", wall)
	wall.call_deferred("initialize", max_hp)

	wall.position = target
	wall.rotation = player.global_position.direction_to(target).angle() + PI/2
