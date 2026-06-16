extends Node2D

var menu_index = 0
enum menu_options {PLAY, CONTROLS}

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		menu_index -= 1
	elif Input.is_action_pressed("move_down"):
		menu_index += 1
	menu_index = clamp(menu_index, 0, len(menu_options)-1)
	
	if Input.is_action_pressed("jump"):
		if menu_index == menu_options.PLAY:
			pass
		elif menu_index == menu_options.PLAY:
			pass 
