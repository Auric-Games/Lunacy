class_name PlayerSkill extends Node 

@export var template_node : PackedScene
@export var combo_string : String = "LLR"

func _ready() -> void:
	await owner.ready