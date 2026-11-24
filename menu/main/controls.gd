extends MainMenuButton

func _ready() -> void:
	if not SaveManager.save_data.beat_game:
		focus_up = $"../../Play/Play"
