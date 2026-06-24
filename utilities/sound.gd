extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_audio_stream_player_finished() -> void:
	queue_free()
