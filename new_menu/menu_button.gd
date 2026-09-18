class_name MainMenuButton extends Button

var outline_time := 0.0
@export var outline_speed := 6.0
@export var outline_variance := 6.0

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if has_focus():
		outline_time += delta * outline_speed
		add_theme_constant_override("outline_size", 45 + outline_variance * sin(outline_time))
		print(text)
	else:
		add_theme_constant_override("outline_size", 0)
