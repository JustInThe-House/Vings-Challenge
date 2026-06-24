extends Node

var Player: RigidBody3D = null
var MasterAudioIndex: int = AudioServer.get_bus_index("Master")
var MasterAudioVolume: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
var volume_perc: int = 68

func _ready() -> void:
#hide mouse always. may need to change if debugging
	if not OS.is_debug_build():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# set global volume to -6 to start so its not too loud (mainly for me)
	#set to -10 for now
	MasterAudioVolume = -10.0
	AudioServer.set_bus_volume_db(MasterAudioIndex, MasterAudioVolume)
	print(MasterAudioVolume)

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("volume_up", true):
		volume_perc = min(volume_perc + 1, 100)
		if MasterAudioVolume < 0.0:
			MasterAudioVolume = min(MasterAudioVolume + 0.1, 0.0)
			AudioServer.set_bus_volume_db(MasterAudioIndex, MasterAudioVolume)
			print(MasterAudioVolume)
		pass
	elif event.is_action_pressed("volume_down", true):
		volume_perc = max(volume_perc - 1, 0)
		if MasterAudioVolume > -48.0:
			MasterAudioVolume = max(MasterAudioVolume - 0.1, -48.0)
			AudioServer.set_bus_volume_db(MasterAudioIndex, MasterAudioVolume)
			print(MasterAudioVolume)
		pass

func set_fullscreen() -> void:
	var mode := DisplayServer.window_get_mode()
	var is_windowed: bool = mode != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	if is_windowed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
