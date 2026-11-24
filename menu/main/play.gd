extends MainMenuButton

func _ready() -> void:
	if not SaveManager.save_data.beat_game:
		focus_down = $"../../Controls/Controls"
		

func press_button(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		Universal.on_controller = true
	else:
		Universal.on_controller = false
	Universal.played_once = true
	Universal.next_scene = "res://rooms/og_collect/og_collect.tscn"
	get_tree().change_scene_to_packed(Universal.loading_screen)
	#get_tree().change_scene_to_file("res://rooms/collect_room.tscn")
	
