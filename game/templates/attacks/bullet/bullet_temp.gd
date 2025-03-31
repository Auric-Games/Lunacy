extends Node2D

@export var speed : float = 6
@export var damage = 20
const PLAYER : int = 0
const ENEMY : int = 1

@export var team =  PLAYER

var direction : Vector2 = Vector2.ZERO

@onready var HitBox_Ref : Area2D = $HitBox
@onready var Sprite : Sprite2D = $BulletSprite
@onready var Animator : AnimatedSprite2D = $Destroyed

func _ready() -> void:
	Sprite.visible = true
	Animator.visible = false
	Animator.stop()
	get_node("ScreenNotifier").connect("screen_exited", delete)

func delete() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed
	if ($HitBox.has_overlapping_areas()) :
		Animator.play("default")
		Animator.visible = true
		Sprite.visible = false
		for body in $HitBox.get_overlapping_bodies() :
			if body.has_method("take_damage"):
				body.take_damage(damage)
				await Animator.animation_finished
				queue_free()
				
