extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.stop()
	#$AnimationPlayer.active = true
	$AnimationPlayer.current_animation = "jumpscare"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("back"):
		get_tree().change_scene_to_file("res://menu/menu.tscn")
