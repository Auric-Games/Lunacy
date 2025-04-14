extends Node2D

@onready var mp_bar = $ProgressBar

func _ready() -> void:
	await owner.ready
	get_parent().mp_changed.connect(update_bar)


func update_bar() -> void :
	mp_bar.value = float(get_parent().current_mp) / get_parent().max_mp * 100
	
	
