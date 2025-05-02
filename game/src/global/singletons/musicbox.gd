extends Node

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() :
	music_player.stream = preload("res://game/assets/audio/music/www.mp3")
	add_child(music_player)
