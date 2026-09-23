extends AudioStreamPlayer

func _ready() -> void:
	Universal.game_paused.connect(_on_game_paused)
	Universal.game_unpaused.connect(_on_game_unpaused)
	
	var music = load("res://music/Ving's Challenge.ogg")
	stream = music
	print(volume_db)

func _on_game_paused() -> void:
	var audio_filter := AudioEffectBandPassFilter.new()
	AudioServer.add_bus_effect(0, audio_filter)
	var tween : Tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "volume_db", -8.0, 1.0)

func _on_game_unpaused() -> void:
	var tween : Tween = get_tree().create_tween().bind_node(self)
	var time := 0.75
	tween.tween_property(self, "volume_db", 0.0, time)
	await get_tree().create_timer(time).timeout
	AudioServer.remove_bus_effect(0, 0)
	
