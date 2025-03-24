extends Node2D

var current_hp : int
signal destroyed()

@onready var collider : Area2D = $Area2D
@onready var hp_indicator : ProgressBar = get_node("HpIndicator/ProgressBar")

func _get_physics_time_scale() -> float:
	return 0.05

func update_hp_indicator() -> void:
	if hp_indicator == null:
		print("hp_indicator is null!")
		return
	hp_indicator.value = current_hp 

func initialize(hp : int) -> void:
	current_hp = hp
	update_hp_indicator()

func _ready() -> void:
	#update_hp_indicator()
	pass

var counter : int = 0
func _physics_process(delta: float) -> void:
	if (counter >= 4) :
		counter = 0
		current_hp -= 1
		update_hp_indicator()
	else :
		counter += 1
	if (current_hp <= 0) :
		print("ice wall destroyed")
		destroyed.emit(self)
		queue_free()
