extends Node2D

var current_hp : int
var immediate_damage : int = 3
var dot_damage : int = 1
signal destroyed()

@onready var hurtbox: Area2D = get_node("DamageBox") :
	set(value) :
		for body in hurtbox.get_overlapping_bodies() :
			print(body)
			if body.has_method("take_damage") :
				body.take_damage(immediate_damage)
			else :
				print("body does not have take_damage method")
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
		if (current_hp <= 0) :
			print("ice wall destroyed")
			destroyed.emit(self)
			queue_free()
	else :
		counter += 1
	
	for body in hurtbox.get_overlapping_bodies() :
		if body.has_method("take_damage") :
			body.take_damage(dot_damage)
		else :
			print("body does not have take_damage method")
