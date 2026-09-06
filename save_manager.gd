extends Node

const SAVE_PATH := "user://save.tres"

var save_data: SaveData

func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_data = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
		print("existing save")
	else:
		save_data = SaveData.new()
		print("new save")
		
	pass # Replace with function body.

func write_to_save() -> void:
	var error_code := ResourceSaver.save(save_data, SAVE_PATH)
	if error_code != OK:
		push_error("Failed to save game: " + error_string(error_code))
	else:
		print("Save Successful!")
