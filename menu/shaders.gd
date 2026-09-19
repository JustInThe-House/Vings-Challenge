extends MainMenuButton

func _ready() -> void:
	text = "Shaders: " + ("OFF" if not SaveManager.save_data.shaders else "ON")

func press_button(_event: InputEvent) -> void:
	if SaveManager.save_data.shaders:
		SaveManager.save_data.shaders = false
	else:
		SaveManager.save_data.shaders = true
	text = "Shaders: " + ("OFF" if not SaveManager.save_data.shaders else "ON")

func back_button(_event: InputEvent) -> void:
	%Back.pressed.emit()
