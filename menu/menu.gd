extends Control

@onready var settings_text: VBoxContainer = %SettingsText
@onready var menu_text: VBoxContainer = %MenuText
@onready var title_text: Label = %Title
@onready var vysnc_text: Label = %Vsync
@onready var controlstext_text: Label = %ControlsText
@onready var volume_text: Label = %Volume
@onready var fpscap_text: Label = %FPSCap
@onready var shaders_text: Label = %Shaders
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var menu_index = 0
var settings_index = 0
var menu_state = "MAIN"
var up_pressed := false
var down_pressed := false


enum menu_options {PLAY, CONTROLS, SETTINGS, EXIT}
enum settings_options {VOLUME, VSYNC, FPS_CAP, SHADERS, BACK}



func _ready() -> void:
	if SaveManager.save_data.beat_game == true:
		$"Actions & Info/WinStar".visible = true
	else:
		$"Actions & Info/WinStar".visible = false
	

	update_main()
	settings_text.visible = false
	#controlstext_text.visible = true
	if not SaveManager.save_data.first_time_playing:
		Music.play()
		if not Universal.played_once:
			animation_player.play("titlecard")
		else:
			if SaveManager.save_data.beat_game and not SaveManager.save_data.first_win:
				animation_player.play("titlecard")
				SaveManager.save_data.first_win = true
			else:
				animation_player.play("finish")

	else:
		print("FIRST TIME")
		SaveManager.save_data.first_time_playing = false
		SaveManager.write_to_save()
		animation_player.play("finish_flash")

# update the menu whenever the player does an action
func update_main() -> void:
	for option in len(menu_options):
		if menu_index == option:
			menu_text.get_child(option).selected = true
		else:
			menu_text.get_child(option).selected = false

func update_settings() -> void:
	for option in len(settings_options):
		if settings_index == option:
			settings_text.get_child(option).selected = true
		else:
			settings_text.get_child(option).selected = false
	vysnc_text.text = "Vsync: " + ("ON" if DisplayServer.window_get_vsync_mode() == 1 else "OFF")
	fpscap_text.text = "60 FPS Cap: " + ("OFF" if Engine.max_fps == 0 else "ON")
	shaders_text.text = "Shaders: " + ("OFF" if not SaveManager.save_data.shaders else "ON")
	


func _input(event: InputEvent) -> void:
	if event.get_action_strength("move_up") > 0.5 and not up_pressed:
		up_pressed = true
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
		controlstext_text.visible = false
		
	elif event.get_action_strength("move_down") > 0.5 and not down_pressed:
		down_pressed = true
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
		controlstext_text.visible = false
	
	elif event.is_action_pressed("jump") and not event.is_action_pressed("fullscreen"):
		UtilsSound.play_sound("res://menu/ui_confirm.wav", -3.0)
		# MAIN MENU
		if menu_state == "MAIN":
			if menu_index == menu_options.PLAY:
				Universal.played_once = true
				if event is InputEventJoypadButton:
					Universal.on_controller = true
				else:
					Universal.on_controller = false
				get_tree().change_scene_to_file("res://rooms/collect_room.tscn")
			elif menu_index == menu_options.CONTROLS:
				controlstext_text.visible = true
			elif menu_index == menu_options.SETTINGS:
				settings_text.visible = true
				menu_text.visible = false
				title_text.visible = false
				settings_index = 0
				update_settings()
				menu_state = "SETTINGS"
			elif menu_index == menu_options.EXIT:
				SaveManager.save_data.volume = Universal.volume_perc
				SaveManager.write_to_save()
				get_tree().quit()
				
		# SETTINGS MENU
		elif menu_state == "SETTINGS":
			if settings_index == settings_options.VSYNC:
				var is_vsync: bool = DisplayServer.window_get_vsync_mode() == 1 # 1 means vsync on; 0 means not
				if is_vsync:
					DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
				else:
					DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			elif settings_index == settings_options.FPS_CAP: # unlimited vs 60fps
				if Engine.max_fps == 0:
					Engine.max_fps = 60
				else:
					Engine.max_fps = 0
			elif settings_index == settings_options.SHADERS:
				if SaveManager.save_data.shaders:
					SaveManager.save_data.shaders = false
				else:
					SaveManager.save_data.shaders = true
			elif settings_index == settings_options.BACK:
				settings_text.visible = false
				menu_text.visible = true
				title_text.visible = true
				menu_state = "MAIN"
		update_settings()
	

	elif event.is_action_pressed("back"):
		if menu_state == "SETTINGS":
			settings_text.visible = false
			menu_text.visible = true
			title_text.visible = true
			SaveManager.write_to_save()
			menu_state = "MAIN"
	
	#release up and down (this is done for controller, otherwise it repeatedly goes up/down when moving stick)
	if event.is_action_released("move_up"):
		up_pressed = false
	if event.is_action_released("move_down"):
		down_pressed = false
			
		
			
			
func _process(delta: float) -> void:
	# settings for volume. done in process to make controller easier
	if menu_state == "SETTINGS" and settings_index == settings_options.VOLUME:
		if Input.is_action_pressed("move_right"):
			Universal.change_volume(0.01 * delta * 10.0)
		elif Input.is_action_pressed("move_left"):
			Universal.change_volume(-0.01 * delta * 10.0)
		
	volume_text.text = "Volume: " + str(int(round(Universal.volume_perc * 100))) + "%" 
