extends Node

var Player: RigidBody3D = null
var MasterAudioIndex: int = AudioServer.get_bus_index("Master")
var MasterAudioVolume: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
var volume_perc: float = 0.3

func _ready() -> void:
	AudioServer.set_bus_volume_db(MasterAudioIndex, linear_to_db(volume_perc))

func change_volume(increment: float = 0.01):
	volume_perc = clamp(volume_perc + increment, 0, 1)
	AudioServer.set_bus_volume_db(MasterAudioIndex, linear_to_db(volume_perc))
	print(linear_to_db(volume_perc))

#volume settings. probably best way to do it, though could be done with a signal
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("volume_up", true):
		change_volume(0.01)
	elif event.is_action_pressed("volume_down", true):
		change_volume(-0.01)

# this makes it so you can tab out of game. in future use, best to use a signal.
func _process(delta: float) -> void:
	if get_tree().get_root().has_focus() and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif not get_tree().get_root().has_focus() and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func set_fullscreen() -> void:
	var mode := DisplayServer.window_get_mode()
	var is_windowed: bool = mode != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	if is_windowed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
