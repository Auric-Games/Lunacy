class_name PlayerUnit extends BaseUnit

# Notes
# implement delta
@export var UnitData : Resource 

@export var camera_ref : Camera2D
@onready var sprite_ref : AnimatedSprite2D = $SpriteController
@onready var weapon_ref : Node2D = $WeaponContainer
@onready var hurt_timer : Timer = $HurtTimer

#@onready var statemachine : StateMachine = $StateMachine

signal player_died

func _ready() -> void :
	if (UnitData != null) :
		_load_data(UnitData)
	print (hurt_timer.name)

func _physics_process(delta: float) -> void:
	camera_ref.follow_mouse()

func _load_data(data : Resource) -> void :
	super._load_data(data)
	pass

func take_damage(value : int) -> void :
	if hurt_timer.is_stopped() :
		hurt_timer.start()
		sprite_ref.play("hurt")
		current_hp -= value
	if (current_hp <= 0) :
		$CollisionShape2D.disabled = true
		player_died.emit("Dead")
		print("Player Died")
	# run death script / destructor
