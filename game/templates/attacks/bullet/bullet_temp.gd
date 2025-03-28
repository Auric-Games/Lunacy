extends Node2D

@export var speed : float = 7.5
@export var damage = 20
const PLAYER : int = 0
const ENEMY : int = 1

@export var team =  PLAYER

var direction : Vector2 = Vector2.ZERO

@onready var HitBox_Ref : Area2D = $HitBox

func _ready() -> void:
	get_node("ScreenNotifier").connect("screen_exited", delete)

func delete() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed
	if ($HitBox.has_overlapping_areas()) :
		for body in $HitBox.get_overlapping_bodies() :
			print("Hit detected with body: " + str(body))
			if body.has_method("take_damage") :
				body.take_damage(damage)
				self.queue_free()
			else:
				print("Body does not have take_damage method")
			
