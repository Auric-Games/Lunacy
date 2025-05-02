extends Node2D

var max_hp : int
var current_hp : int :
	set(value) :
		current_hp = value
		hp_changed.emit(self, value)
var immediate_damage : int = 10
var dot_damage : int = 5

var timer : Timer = Timer.new()

signal destroyed()
signal hp_changed

@onready var hurtbox: Area2D = get_node("DamageBox") :
	set(value) :
		for body in hurtbox.get_overlapping_bodies() :
			if body.has_method("take_damage") :
				body.take_damage(immediate_damage)
			else :
				print("body does not have take_damage method")
@onready var hp_indicator : ProgressBar = get_node("HpIndicator/ProgressBar")

func _get_physics_time_scale() -> float:
	return 0.05

func initialize(hp : int) -> void:
	max_hp = hp
	current_hp = hp

func _ready() -> void:
	timer.one_shot = true
	timer.wait_time = 0.5
	timer.start()

var counter : int = 0
func _physics_process(delta: float) -> void:
	if (counter >= 20) :
		counter = 0
		current_hp -= 2
		if (current_hp <= 0) :
			print("ice wall destroyed")
			destroyed.emit(self)
			queue_free()
	else :
		counter += 1
	
	if timer.is_stopped() && counter == 0:
		for body in hurtbox.get_overlapping_bodies() :
			if body.has_method("take_damage") && counter == 0: # Only apply dot damage every 4 frames
				body.take_damage(dot_damage)
				current_hp -= 5
			else :
				print("body does not have take_damage method")
				
	elif (hurtbox.has_overlapping_bodies() && counter <= 4) :
		for body in hurtbox.get_overlapping_bodies() :
			if body.has_method("take_damage") :
				body.take_damage(immediate_damage) # Stop the timer to apply immediate damage

