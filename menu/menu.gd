extends Control

var menu_index = 0
var settings_index = 0
var menu_state = "MAIN"
enum menu_options {PLAY, CONTROLS, SETTINGS, EXIT}
enum settings_options {VOLUME, FULLSCREEN, VSYNC, BACK}


func _ready() -> void:
	Music.play()
	update_main()
	$SettingsText.visible = false
	$ControlsText.visible = true

# update the menu whenever the player does an action
func update_main() -> void:
	for option in len(menu_options):
		if menu_index == option:
			$MenuText.get_child(option).selected = true
		else:
			$MenuText.get_child(option).selected = false

func update_settings() -> void:
	for option in len(settings_options):
		if settings_index == option:
			$SettingsText.get_child(option).selected = true
		else:
			$SettingsText.get_child(option).selected = false
	$SettingsText/Fullscreen.text = "Fullscreen: " + ("ON" if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else "OFF")
	$SettingsText/Vsync.text = "Vsync: " + ("ON" if DisplayServer.window_get_vsync_mode() == 1 else "OFF")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		UtilsSound.play_sound("res://menu/ui_move.wav", -3.0)
		if menu_state == "MAIN":
			if menu_index == 0:
				menu_index = len(menu_options)-1
			else:
				menu_index -= 1
			update_main()
		if menu_state == "SETTINGS":
			if settings_index == 0:
				settings_index = len(settings_options)-1
			else:
				settings_index -= 1
			update_settings()
		$ControlsText.visible = false
		
	
	elif event.is_action_pressed("move_down"):
		UtilsSound.play_sound("res://menu/ui_move.wav", -3.0)
		if menu_state == "MAIN":
			if menu_index == len(menu_options)-1:
				menu_index = 0
			else:
				menu_index += 1
			update_main()
		elif menu_state == "SETTINGS":
			if settings_index == len(settings_options)-1:
					settings_index = 0
			else:
				settings_index += 1
			update_settings()
		$ControlsText.visible = false
	
	
	elif event.is_action_pressed("jump") and not event.is_action_pressed("fullscreen"):
		UtilsSound.play_sound("res://menu/ui_confirm.wav", -3.0)
		# MAIN MENU
		if menu_state == "MAIN":
			if menu_index == menu_options.PLAY:
				get_tree().change_scene_to_file("res://rooms/collect_room.tscn")
			elif menu_index == menu_options.CONTROLS:
				$ControlsText.visible = true
			elif menu_index == menu_options.SETTINGS:
				$SettingsText.visible = true
				$MenuText.visible = false
				$Title.visible = false
				settings_index = 0
				update_settings()
				menu_state = "SETTINGS"
			elif menu_index == menu_options.EXIT:
				get_tree().quit()
				
		# SETTINGS MENU
		elif menu_state == "SETTINGS":
			if settings_index == settings_options.FULLSCREEN:
				Universal.set_fullscreen()
			elif settings_index == settings_options.VSYNC:
				var is_vsync: bool = DisplayServer.window_get_vsync_mode() == 1 # 1 means vsync on; 0 means not
				if is_vsync:
					DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
				else:
					DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
				print(DisplayServer.window_get_vsync_mode())
			elif settings_index == settings_options.BACK:
				$SettingsText.visible = false
				$MenuText.visible = true
				$Title.visible = true
				menu_state = "MAIN"
		update_settings()
	

	elif event.is_action_pressed("back"):
		if menu_state == "SETTINGS":
			$SettingsText.visible = false
			$MenuText.visible = true
			$Title.visible = true
			menu_state = "MAIN"
			
			
		# settings for volume
	if menu_state == "SETTINGS" and settings_index == settings_options.VOLUME:
		if event.is_action_pressed("move_right", true):
			Universal.change_volume(0.01)
		elif event.is_action_pressed("move_left", true):
			Universal.change_volume(-0.01)
			
			
func _process(_delta: float) -> void:
	$SettingsText/Volume.text = "Volume: " + str(int(round(Universal.volume_perc * 100))) + "%" 
