extends Node

func play_sound(stream: String, volume_db: float = 0.0) -> void:
	var sound = preload("res://utilities/sound.tscn").instantiate()
	sound.get_node("%AudioStreamPlayer").stream =  load(stream)
	sound.get_node("%AudioStreamPlayer").volume_db = volume_db
	get_parent().add_child(sound)
# add and autoload a scene that holds all sounds. this way if sound "creator" dies it doesnt get cut off
# do same for music
