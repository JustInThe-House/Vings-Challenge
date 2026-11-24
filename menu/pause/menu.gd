extends MainMenuButton

func press_button(_event: InputEvent) -> void:
	Universal.game_unpaused.emit()
	get_tree().change_scene_to_file(Universal.main_menu_scene)
	$"../../../..".queue_free()
