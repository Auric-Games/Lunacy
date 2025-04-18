extends Node2D

@onready var hp_bar = $ProgressBar

func _ready() -> void:
	await owner.ready
	get_parent().hp_changed.connect(update_bar)


func update_bar(_self, _val) -> void :
	hp_bar.value = float(_val) / get_parent().max_hp * 100
	
	
