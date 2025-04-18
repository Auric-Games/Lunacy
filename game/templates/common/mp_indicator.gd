extends Node2D

@onready var mp_bar = $ProgressBar

func _ready() -> void:
	await owner.ready
	get_parent().mp_changed.connect(update_bar)


func update_bar(_self, _val) -> void :
	mp_bar.value = float(_val) / get_parent().max_mp * 100
	
	
