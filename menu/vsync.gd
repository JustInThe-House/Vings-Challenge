extends MainMenuButton

func _ready() -> void:
	text = "Vsync: " + ("ON" if DisplayServer.window_get_vsync_mode() == 1 else "OFF")

func press_button(_event: InputEvent) -> void:
	var is_vsync: bool = DisplayServer.window_get_vsync_mode() == 1 # 1 means vsync on; 0 means not
	if is_vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	text = "Vsync: " + ("ON" if DisplayServer.window_get_vsync_mode() == 1 else "OFF")

func back_button(_event: InputEvent) -> void:
	%Back.pressed.emit()
