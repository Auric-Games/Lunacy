extends Control

func _ready():
	start_sound()
	Musicbox.music_player.finished.connect(start_sound)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/gameplay/lvl_test.tscn")

func start_sound() -> void:
	Musicbox.music_player.play()


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/credits/GodotCredits.tscn")
