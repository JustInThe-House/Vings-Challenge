extends MainMenuButton

func press_button(_event: InputEvent) -> void:
	# restart room if  first room, otherwise set to first room
	#get_tree().reload_current_scene()
	Universal.game_unpaused.emit()
	get_tree().change_scene_to_file("res://rooms/collect_room.tscn")
	$"../../..".queue_free()
