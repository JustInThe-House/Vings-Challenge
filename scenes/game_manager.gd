extends Node

var dolls_remaining = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func add_point():
	dolls_remaining += 1
	print(dolls_remaining)
