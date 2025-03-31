extends PlayerState

signal game_over

func _ready():
	can_move = false;
	can_attack = false;
	super()

func enter(_previous_state_path: String, data := {}):
	player.velocity = Vector2.ZERO
	player.sprite_ref.play("die")
	game_over.emit()