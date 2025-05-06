extends PlayerSkill

@export var damage : int = 30 # Damage dealt by the bullets
@export var bullet_count : int = 5 # Number of bullets to spawn
@export_range(0, PI/2) var bullet_spread : float = PI/6
@export var sfx : AudioStream = preload("res://game/assets/audio/sounds/enchant.mp3")

func _ready() -> void:
	super()

	template_node = preload("res://game/templates/attacks/bullet/bullet_temp.tscn")
	combo_string = "LLL"

	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 4

	mana_cost = 35

func do_skill() -> void :
	var mouse_pos : Vector2 = player.get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player.global_position

	var temp_timer : Timer = Timer.new()
	temp_timer.wait_time = 0.05
	temp_timer.one_shot = true
	add_child(temp_timer)

	# Create a new instance of the bullet template
	for i in bullet_count :
		var vector_mod : Vector2 = mouse_delta.normalized()
		var bullet = template_node.instantiate()

		bullet.damage = damage * get_parent().get_parent()._current_mult
		bullet.position = player.global_position + (20 * vector_mod.normalized())
		bullet.direction = mouse_delta.normalized().rotated(i * (bullet_spread / bullet_count) - (bullet_spread / 2))
		bullet.scale = Vector2(8, 8)

		bullet.rotate(bullet.direction.angle()) # Spread the bullets evenly based on the count
		#print(bullet.rotation)

		get_tree().current_scene.call_deferred("add_child", bullet)
		temp_timer.start()
		AudioMixer.play_sfx(sfx, -7)
		await temp_timer.timeout
	temp_timer.queue_free()
