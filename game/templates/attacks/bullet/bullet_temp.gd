extends Node2D

@export var speed : float = 6
@export var damage = 30
const PLAYER : int = 0
const ENEMY : int = 1

@export var team =  PLAYER
@export var sfx : AudioStream = preload("res://game/assets/audio/sounds/explode5.mp3")

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
				play_death_sound()
				stopped = true
				body.take_damage(damage)
				damage = 0
				await Sprite.animation_finished
				delete()
	if !stopped :
		move()

var bool_one : bool = false

func play_death_sound() -> void:
	if !bool_one :
		bool_one = true
		AudioMixer.play_sfx(sfx, -10)

func move() -> void :
	position += direction * speed
