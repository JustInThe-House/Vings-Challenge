extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		SoundManager.play_sound("res://gameover/death.wav", 2.0)
		## set Game state to LOSE_FALLING and set these below:
		body.gravity_scale = 12.0
		if body.camera_pivot:
			body.camera_pivot.frozen = true
		# (this is @onready var camera_springarm := $Jawsh/SpringArmPivot)
		
		await get_tree().create_timer(1.1, true, true, false).timeout
		# for some reason doing it based on physics time was the answer? 
		# i guess, since the timer creation is based on collision (jawsh and death barrier)
		get_tree().change_scene_to_file(Universal.game_over_scene)
	pass # Replace with function body.
