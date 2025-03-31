extends PlayerSkill

@export var bullet_count : int = 5 # Number of bullets to spawn
@export var bullet_spread : float = PI/6

func _ready() -> void:
	super()

	template_node = preload("res://game/templates/attacks/bullet/bullet_temp.tscn")
	combo_string = "LLL"

func left_screen() -> void:
	# This function can be used to handle logic when the bullet leaves the screen
	# For example, you could queue_free() the bullet or reset its position
	queue_free()
	# You can add logic here if needed

func start() -> void :
	var mouse_pos : Vector2 = player.get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player.global_position

	# Create a new instance of the bullet template
	for i in bullet_count :
		var vector_mod : Vector2 = mouse_delta.normalized()
		var bullet = template_node.instantiate()

		bullet.position = player.global_position + (20 * vector_mod.normalized())
		bullet.direction = mouse_delta.normalized().rotated(i * (bullet_spread / bullet_count) - (bullet_spread / 2))

		bullet.rotate(  i * (bullet_spread / bullet_count) - (bullet_spread / 2) ) # Spread the bullets evenly based on the count
		print(bullet.rotation)
		get_tree().current_scene.call_deferred("add_child", bullet)
	
