extends MainMenuButton

func press_button(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		Universal.on_controller = true
	else:
		Universal.on_controller = false
	Universal.played_once = true
	Universal.next_scene = "res://rooms/collect_room.tscn"
	get_tree().change_scene_to_packed(Universal.loading_screen)
