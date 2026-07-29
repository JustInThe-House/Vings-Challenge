extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var music = load("res://music/Ving's Challenge.ogg")
	stream = music
	pass # Replace with function body.
