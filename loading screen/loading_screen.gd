extends Control

func _ready() -> void:
	ResourceLoader.load_threaded_request(Universal.next_scene)

func _process(delta: float) -> void:
	var progress := []
	ResourceLoader.load_threaded_get_status(Universal.next_scene, progress)
	#$progress_bar.value = progress[0] * 100
	
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(Universal.next_scene)
		get_tree().change_scene_to_packed(packed_scene)
