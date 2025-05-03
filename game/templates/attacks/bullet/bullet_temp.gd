extends Node2D

@export var speed : float = 6
@export var damage = 30
const PLAYER : int = 0
const ENEMY : int = 1

@export var team =  PLAYER

var direction : Vector2 = Vector2.ZERO
var stopped : bool = false

@onready var HitBox_Ref : Area2D = $HitBox
@onready var Sprite : AnimatedSprite2D = $BulletSprite

func _ready() -> void:
	Sprite.play("default")
	get_node("ScreenNotifier").connect("screen_exited", delete)

func delete() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	if ($HitBox.has_overlapping_areas()) :
		for body in $HitBox.get_overlapping_bodies() :
			if !body :
				continue
			if body.has_method("take_damage"):
				Sprite.play("destroyed")
				stopped = true
				body.take_damage(damage)
				damage = 0
				await Sprite.animation_finished
				delete()
	if !stopped :
		move()



func move() -> void :
	position += direction * speed
