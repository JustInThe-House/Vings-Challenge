extends Label

var time := 0.0
@export var size_timespeed := 3.0

func _process(delta: float) -> void:
	time += delta * size_timespeed
	scale = Vector2(1.0 + pow(cos(time),2)*0.3, 1.0 + pow(cos(time),2)*0.0625)
	rotation = sin(time)/8


func _on_settings_pressed() -> void:
	visible = false


func _on_back_pressed() -> void:
	visible = true
