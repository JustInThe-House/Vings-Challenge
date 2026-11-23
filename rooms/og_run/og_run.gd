extends Room

func _ready() -> void:
	super._ready()
	var jawsh := %Jawsh
	if SaveManager.save_data.shaders:
		CRT.material.set("shader_parameter/alpha", 1.0)
	Game.state = Game.GameState.FROZEN
	Music.play()
	Music.seek(57.8)
	await get_tree().create_timer(1.5).timeout
	Music.pitch_scale = 1.3
	# pause music, play scary scream, then play music pitched up
	await get_tree().create_timer(0.5).timeout
	Game.state = Game.GameState.ACTIVE
	var run_title = preload("res://rooms/ui_run.tscn").instantiate()
	run_title.position.y = 720.0
	add_child(run_title)
	move_child(run_title, 6)

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	Music.pitch_scale = 1.0

func _unhandled_input(event: InputEvent) -> void:
	if Game.state == Game.GameState.ACTIVE and event.is_action_pressed("pause"):
		var pause_menu = preload("res://menu/pause/pause_menu.tscn").instantiate()
		Universal.game_paused.emit()
		add_child(pause_menu)
