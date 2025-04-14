extends Camera2D

@export var INPUT_RADIUS : float = 100
@export var CAMERA_BOUND : float = 200 
@export var CAMERA_SPEED : float = 0.04 # 0 -> 1.0

@onready var viewport_color : ColorRect = $Control2/ColorRect

var player_ref : PlayerUnit 
@onready var combo_container : GridContainer = $Control/ComboGrid
@onready var resource_container : GridContainer = $Control/ResourceGrid

var timer : Timer
var combo_count : int = 0
const NO_CLICK : Texture2D = preload("res://prototypes/assets/common/kenney_input-prompts-pixel-16/Tiles/tile_0076.png")
const LEFT_CLICK : Texture2D = preload("res://prototypes/assets/common/kenney_input-prompts-pixel-16/Tiles/tile_0077.png")
const RIGHT_CLICK : Texture2D = preload("res://prototypes/assets/common/kenney_input-prompts-pixel-16/Tiles/tile_0078.png")

func _ready() -> void:
	player_ref = get_parent().get_node("PlayerUnit")
	position = player_ref.position

	get_parent().get_node("PlayerUnit/StateMachine/SkillMode").entered.connect(toggle_combo_color)
	get_parent().get_node("PlayerUnit/StateMachine/SkillMode").combo_input.connect(update_combo)
	get_parent().get_node("PlayerUnit/StateMachine/SkillMode").combo_attempt.connect(combo_end)
	timer = Timer.new()
	timer.wait_time = 1
	timer.one_shot = true

	timer.timeout.connect(reset_combo)
	add_child(timer)

	get_parent().get_node("PlayerUnit").hp_changed.connect(update_hp)
	get_parent().get_node("PlayerUnit").mp_changed.connect(update_mp)

	reset_combo()


func _process(delta: float) -> void:
	pass

func follow_mouse() -> void :
	#move mouse to center between player and mouse
	var mouse_pos : Vector2 = get_global_mouse_position()
	var mouse_delta : Vector2 = mouse_pos - player_ref.global_position
	var distance : float = mouse_delta.length()

	if (distance > INPUT_RADIUS) :
		var target : Vector2 = mouse_delta.normalized() * distance / 2 + player_ref.global_position
		
		move_to_pos(target)
	else :
		move_to_pos(player_ref.global_position)


func move_to_pos(target : Vector2, speed : float = CAMERA_SPEED) -> void :
	position = position.lerp(target, speed)

func update_hp() -> void :
	resource_container.get_node("HP").value = float(player_ref.current_hp) / player_ref.max_hp * 100
func update_mp() -> void :
	resource_container.get_node("MP").value = float(player_ref.current_mp) / player_ref.max_mp * 100


func update_combo(input : int) -> void :
	match input :
		0 : 
			reset_combo()
		1, 2 : 
			if !timer.is_stopped() :
				timer.stop()
				reset_combo()
			if input == 1 : 
				combo_container.get_child(combo_count).texture = LEFT_CLICK
				combo_container.get_child(combo_count).modulate.a = 0.8
			else :
				combo_container.get_child(combo_count).texture = RIGHT_CLICK
				combo_container.get_child(combo_count).modulate.a = 0.8
			combo_count += 1
		_:
			printerr("something went wrong in combo input visualizer")
		
func combo_end(_value : String) -> void :
	timer.start()
	combo_count = 0

func reset_combo() -> void :
	for child in combo_container.get_children() :
		child.texture = NO_CLICK
		child.modulate.a = 0.5

func toggle_combo_color(toggle : bool) -> void :
	print("toggling")
	var tween : Tween = create_tween()
	if toggle :
		tween.tween_property(viewport_color, "color", Color(0.125, 0.125, 0.125, 0.125), 0.15)
		tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "zoom", zoom+Vector2(0.1,0.1), 0.1)
		print(viewport_color.color.a)
	else :
		tween.tween_property(viewport_color, "color", Color(0.125, 0.125, 0.125, 0), 0.15)
		tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "zoom", zoom-Vector2(0.1,0.1), 0.1)
		print(viewport_color.color.a)
