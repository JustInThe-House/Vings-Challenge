extends MainMenuButton

@export var scene: PackedScene

func press_button(_event: InputEvent) -> void:
	# restart room if  first room, otherwise set to first room
	Universal.game_unpaused.emit()
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_packed(scene)
	#$"../../../..".queue_free()
