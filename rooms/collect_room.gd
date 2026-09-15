extends Node3D

@onready var jawsh := %Jawsh
@onready var dolls := %Dolls
@onready var camera_springarm := $Jawsh/SpringArmPivot
@onready var ving := %Ving
var dolls_collected: float = 0
var total_dolls: int
var dolls_left: int
var gameover_fall: bool = false
@onready var CRT: ColorRect = $CRT
@onready var dolls_left_text := $DollsLeft

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play()
	total_dolls = dolls.get_child_count()
	dolls_left = total_dolls
	dolls_left_text.text = "Dolls Left: " + str(dolls_left)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
			get_tree().change_scene_to_file("res://run_room.tscn")
		ving.fury = 1.0 - (dolls_left_actual/total_dolls)
	dolls_left = dolls_left_actual
	dolls_left_text.text = "Dolls Left: " + str(dolls_left)
	
	var distance: float = jawsh.position.distance_to(ving.position)
	if distance < 80.0 and SaveManager.save_data.shaders:
		CRT.material.set("shader_parameter/alpha", 0.6 * (1 - distance/80.0))
		CRT.material.set("shader_parameter/vinnette_outer_radius", 0.2 + 0.5 * (distance/80.0))
		pass
	
