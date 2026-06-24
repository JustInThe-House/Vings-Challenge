extends Node

var dolls_collected = 0
const dolls_total = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = %Jawsh
	%Ving.player = player
	pass

func add_point():
	dolls_collected += 1
	%Ving.fury += 1/dolls_total
	print(dolls_collected)
