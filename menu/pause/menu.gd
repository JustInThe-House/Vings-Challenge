extends MainMenuButton

func press_button(_event: InputEvent) -> void:
	get_tree().change_scene_to_file(Universal.main_menu_scene)
