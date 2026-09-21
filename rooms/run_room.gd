extends Node3D

@onready var jawsh := %Jawsh
@onready var plushies := %Plushies
@onready var camera_springarm := $Jawsh/SpringArmPivot
var plushies_collected: float = 0
var total_plushies: float
var plushies_left: float
var gameover_fall: bool = false
@onready var CRT: ColorRect = $CRT

func _ready() -> void:
	if SaveManager.save_data.shaders:
		CRT.material.set("shader_parameter/alpha", 1.0)
	jawsh.CAN_MOVE = false
	Music.play()
	Music.seek(57.8)
	total_plushies = plushies.get_child_count()
	plushies_left = total_plushies
	await get_tree().create_timer(1.5).timeout
	Music.pitch_scale = 1.3
	# pause music, play scary scream, then play music pitched up
	await get_tree().create_timer(0.5).timeout
	jawsh.CAN_MOVE = true
	var run_title = preload("res://rooms/ui_run.tscn").instantiate()
	run_title.position.y = 720.0
	add_child(run_title)
	move_child(run_title, 6)
	

func _process(delta: float) -> void:
	var plushies_left_actual: float = plushies.get_child_count()
	if plushies_left != plushies_left_actual:
		if plushies_left_actual == 0:
			get_tree().change_scene_to_file("res://youwin/youwin.tscn")
		print(plushies_left_actual)
	plushies_left = plushies_left_actual
	
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	Music.pitch_scale = 1.0


func _on_death_barrier_body_entered(body: Node3D) -> void:
	if body == jawsh:
		UtilsSound.play_sound("res://gameover/death.wav", 2.0)
		jawsh.gravity_scale = 12.0
		camera_springarm.frozen = true
		await get_tree().create_timer(1.1, true, true, false).timeout
		# for some reason doing it based on physics time was the answer? 
		# i guess, since the timer creation is based on collision (jawsh and death barrier)
		get_tree().change_scene_to_file(Universal.game_over_scene)
