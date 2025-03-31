extends Node2D

var i : int = 0
var tween : Tween

func init() -> void :
	pass

func _ready():
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0, 0), 0.2)
	await tween.finished
	delete()

func _process(delta: float) -> void:
	if i % 60 == 0 :
		if $HitBox.has_overlapping_bodies() :
			for body in $HitBox.get_overlapping_bodies():
				if body.has_method("take_damage"):
					if (body is PlayerUnit):
						continue
					else:
						body.take_damage(5)
	i += 1

func delete() -> void :
	queue_free()
