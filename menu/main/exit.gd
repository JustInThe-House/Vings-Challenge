extends MainMenuButton

func press_button(_event: InputEvent) -> void:
	SaveManager.save_data.volume = Universal.volume_perc
	SaveManager.write_to_save()
	get_tree().quit()
