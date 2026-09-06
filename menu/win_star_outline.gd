extends Polygon2D

var time := 0.0
var outline_size := 2.2
var sine_factor := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * outline_size
	scale = Vector2(outline_size + sine_factor * sin(time),outline_size + sine_factor * sin(time))
