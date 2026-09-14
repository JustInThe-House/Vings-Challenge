extends Label

var time := 0.0

func _process(delta: float) -> void:
	time += delta * (1.2)
	rotation = sin(time) * PI/64
	pass
