extends Label

func _ready() -> void:
	visible = true

func _on_controls_pressed() -> void:
	visible = true

func _on_controls_focus_exited() -> void:
	visible = false
