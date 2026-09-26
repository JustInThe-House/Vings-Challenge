extends AudioStreamPlayer

func _ready() -> void:
	Universal.game_paused.connect(_on_game_paused)
	Universal.game_unpaused.connect(_on_game_unpaused)
	
	var music = load("res://music/Ving's Challenge.ogg")
	stream = music

func _on_game_paused() -> void:
	var audio_filter := AudioEffectBandPassFilter.new()
	AudioServer.add_bus_effect(0, audio_filter)
	volume_db = -6.0

func _on_game_unpaused() -> void:
	volume_db = 0.0
	AudioServer.remove_bus_effect(0, 0)
	
