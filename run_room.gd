extends Node3D

@onready var jawsh := %Jawsh
@onready var dolls := %Dolls
@onready var camera_springarm := $Jawsh/SpringArmPivot
var dolls_collected: float = 0
var total_dolls: float
var dolls_left: float
var gameover_fall: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jawsh.CAN_MOVE = false
	Music.play()
	Music.seek(57.8)
	total_dolls = dolls.get_child_count()
	dolls_left = total_dolls
	print(total_dolls)
	await get_tree().create_timer(1.5).timeout
	Music.pitch_scale = 1.3
	# pause music, play scary scream, then play music pitched up
	await get_tree().create_timer(0.5).timeout
	jawsh.CAN_MOVE = true
	var run_title = preload("res://rooms/ui_run.tscn").instantiate()
	run_title.position.y = 720.0
	add_child(run_title)
	

func _process(delta: float) -> void:
	if jawsh.global_position.y < -5.0:
		if gameover_fall != true:
			gameover_fall = true
			UtilsSound.play_sound("res://gameover/death.wav", 2.0)
			jawsh.gravity_scale = 12.0
			camera_springarm.frozen = true
	if jawsh.global_position.y < -80.0:
		get_tree().change_scene_to_file("res://gameover/gameover.tscn")
	var dolls_left_actual: float = dolls.get_child_count()
	if dolls_left != dolls_left_actual:
		if dolls_left_actual == 0:
			get_tree().change_scene_to_file("res://youwin/youwin.tscn")
		print(dolls_left_actual)
	dolls_left = dolls_left_actual
	
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	Music.pitch_scale = 1.0
