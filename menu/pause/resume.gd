extends MainMenuButton

func press_button(_event: InputEvent) -> void:
	Universal.game_unpaused.emit()
	$"../../..".queue_free()
