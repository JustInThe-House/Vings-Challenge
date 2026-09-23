extends Node

var MasterAudioIndex: int = AudioServer.get_bus_index("Master")
var MasterAudioVolume: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
var volume_perc: float = 0.6
var played_once: bool = false
var on_controller: bool = false
var main_menu_scene: String = "res://menu/menu.tscn"

var game_over_scene: String = "res://gameover/gameover.tscn"

signal game_paused
signal game_unpaused

func _init() -> void:
	if OS.is_debug_build():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass

func _ready() -> void:
	volume_perc = SaveManager.save_data.volume
	AudioServer.set_bus_volume_db(MasterAudioIndex, linear_to_db(volume_perc))
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func change_volume(increment: float = 0.01):
	volume_perc = clamp(volume_perc + increment, 0, 1)
	AudioServer.set_bus_volume_db(MasterAudioIndex, linear_to_db(volume_perc))
	print(linear_to_db(volume_perc))

#volume settings. probably best way to do it, though could be done with a signal
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("volume_up", true):
		change_volume(0.01)
	elif event.is_action_pressed("volume_down", true):
		change_volume(-0.01)
	
	# other universal controls, not specifically set to a controller
	if event.is_action_pressed("fullscreen"):
		Universal.set_fullscreen()
	elif event.is_action_pressed("quit"):
		get_tree().quit()

# this lets you can tab out of game.
func _notification(what: int) -> void:
	match what:
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
# required fullscreen for actual game, otherwise there are issues with moving the window while also capturing mouse.
# this is also why i removed its button in Menu.
func set_fullscreen() -> void:
	if OS.is_debug_build():
		var mode := DisplayServer.window_get_mode()
		var is_windowed: bool = mode != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
		if is_windowed:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
