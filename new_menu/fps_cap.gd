extends MainMenuButton

func _ready() -> void:
	text = "60 FPS Cap: " + ("OFF" if Engine.max_fps == 0 else "ON")

func press_button(_event: InputEvent) -> void:
	# unlimited vs 60fps
	if Engine.max_fps == 0:
		Engine.max_fps = 60
	else:
		Engine.max_fps = 0
	text = "60 FPS Cap: " + ("OFF" if Engine.max_fps == 0 else "ON")

func back_button(event: InputEvent) -> void:
	%Back.pressed.emit()
