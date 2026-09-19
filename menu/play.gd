extends MainMenuButton

func press_button(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		Universal.on_controller = true
	else:
		Universal.on_controller = false
	Universal.played_once = true
	get_tree().change_scene_to_file("res://rooms/collect_room.tscn")
