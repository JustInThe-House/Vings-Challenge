extends MainMenuButton

func press_button(_event: InputEvent) -> void:
	pressed.emit()
