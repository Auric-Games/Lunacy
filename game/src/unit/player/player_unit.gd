class_name PlayerUnit extends BaseUnit

# Notes
# implement delta
@export var UnitData : Resource 

@export var camera_ref : Camera2D
@onready var sprite_ref : AnimatedSprite2D = $SpriteController
@onready var weapon_ref : Node2D = $WeaponContainer
@onready var hurt_timer : Timer = $HurtTimer

#@onready var statemachine : StateMachine = $StateMachine

@export var max_mp : int = 200 :
	set(value) :
		max_mp = value
@export var current_mp : int = 200 :
	set(value) :
		mp_changed.emit()
		current_mp = value

@export var mana_regen : int = 5

signal player_died
signal mp_changed

var frame_counter = 0;

func _ready() -> void :
	if (UnitData != null) :
		_load_data(UnitData)
	print (hurt_timer.name)

func _physics_process(delta: float) -> void:
	camera_ref.follow_mouse()

	if current_mp != max_mp :
		regenerate_mp()
	frame_counter += 1


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

func regenerate_mp() -> void :
	current_mp += mana_regen
	current_mp = clamp(current_mp, 0, max_mp)
