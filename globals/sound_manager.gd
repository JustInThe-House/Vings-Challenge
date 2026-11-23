extends Node

func play_sound(stream: String, volume: float = 1.0) -> void:
	var sound: AudioStreamPlayer = preload("res://globals/sound.tscn").instantiate()
	sound.stream =  load(stream)
	sound.volume_db = volume
	get_parent().add_child(sound)
# add and autoload a scene that holds all sounds. this way if sound "creator" dies it doesnt get cut off
# do same for music

func stop_sound(sound: AudioStreamPlayer) -> void:
	sound.queue_free()
