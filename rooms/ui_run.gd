extends Control


@export var speed: float = 5.0

func _physics_process(delta: float) -> void:
	position.y -= delta * speed
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("HIIII")
	queue_free()
