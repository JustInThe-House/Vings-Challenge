extends Node

var Player: RigidBody3D = null
var MasterAudioIndex: int = AudioServer.get_bus_index("Master")
var MasterAudioVolume: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
var volume_perc: float = 0.3

func _ready() -> void:
#hide mouse always. may need to change if debugging
	#if not OS.is_debug_build():
	if OS.is_debug_build():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pass
	
	AudioServer.set_bus_volume_db(MasterAudioIndex, linear_to_db(volume_perc))

func change_volume(increment: float = 0.01):
	volume_perc = clamp(volume_perc + increment, 0, 1)
	AudioServer.set_bus_volume_db(MasterAudioIndex, linear_to_db(volume_perc))
	print(linear_to_db(volume_perc))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("volume_up", true):
		change_volume(0.01)
	elif event.is_action_pressed("volume_down", true):
		change_volume(-0.01)


func set_fullscreen() -> void:
	var mode := DisplayServer.window_get_mode()
	var is_windowed: bool = mode != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	if is_windowed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
