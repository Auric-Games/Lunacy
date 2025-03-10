extends Node2D

func _physics_process(delta: float) -> void:
    var mouse_pos : Vector2 = get_global_mouse_position()
    look_at(mouse_pos)