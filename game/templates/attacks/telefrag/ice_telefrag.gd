extends Node2D



func init() -> void :
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(2, 2), 0.5)
	tween.finished.connect(_stop)

func _process(delta: float) -> void:
	if $Area2D.has_overlapping_bodies() :
		for body in $Area2D.get_overlapping_bodies():
			if body.has_method("take_damage"):
				if (body.is("PlayerUnit")):
					continue
				else:
					body.take_damage(10)

func _stop() -> void :
	queue_free()