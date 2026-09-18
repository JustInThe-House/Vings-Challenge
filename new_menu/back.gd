extends MainMenuButton

func press_button(_event: InputEvent) -> void:
	pressed.emit()

func back_button(_event: InputEvent) -> void:
	pressed.emit()
