extends PlayerSkill

@export var limit : int = 10
var count : int = 0

func _ready() -> void:
	var wall = template_node.instantiate()
	
	template_node = preload("res://game/templates/skills/player_skills/IceWall.tscn")
	super()

