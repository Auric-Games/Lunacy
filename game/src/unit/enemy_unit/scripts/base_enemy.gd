extends BulletUnit
class_name BaseEnemyUnit

var ai_component

func _ready() -> void :
	ai_component = get_node("ComponentContainer").get_node("BasicAi")

func _physics_process(delta: float) -> void:
	ai_component.move_to_player(delta, 3)
