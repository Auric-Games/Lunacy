extends Area2D

@onready var whirlpoolArea : CollisionShape2D
@export var whirlpoolStrength : float = 50

func _init() -> void :
  whirlpoolArea = CollisionShape2D.new()
  add_child(whirlpoolArea);
  whirlpoolArea.owner = self

func _ready() -> void :
  var shape = CircleShape2D.new()
  shape.radius = 100
  whirlpoolArea.shape = shape

func _physics_process(_delta : float) -> void :
  for area in get_overlapping_areas() :
    if !(area.owner is BaseUnit) :
      continue
    
    var unit : BaseUnit = area.owner
    var dir = Vector2(unit.position - position).normalized
    var tangent : Vector2 = Vector2(-dir.y, dir.x) # - or + based on whirlpool direction

    unit.velocity += (tangent - dir) * whirlpoolStrength