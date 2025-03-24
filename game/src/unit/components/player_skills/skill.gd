class_name PlayerSkill extends Node 

@export var template_node : PackedScene

func _ready() -> void:
	await owner.ready