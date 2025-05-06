extends Node

@onready var SFX_Player : AudioStreamPlayer = AudioStreamPlayer.new()
@onready var EXTRA_Player : AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	SFX_Player.bus = "SFX"
	SFX_Player.max_polyphony = 32
	SFX_Player.stream = AudioStreamPolyphonic.new()

	add_child(SFX_Player)
	SFX_Player.play()

func play_sfx(sfx : AudioStream, volume : float = 0, pitch : float = 1, type : float = 0) -> void:
	if sfx :
		var sfx_playback : AudioStreamPlayback = SFX_Player.get_stream_playback()
		sfx_playback.play_stream(sfx, 0, volume, pitch, type, "SFX")
	else :
		print("AudioMixer: No sound effect provided to play_sfx()")
		return
