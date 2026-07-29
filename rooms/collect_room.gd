extends Node3D

var dolls_collected: float = 0
var total_dolls: float
var dolls_left: float
var gameover_fall: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play()
	total_dolls = %Dolls.get_child_count()
	dolls_left = total_dolls
	print(total_dolls)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(%Jawsh.position.y)
	if %Jawsh.global_position.y < -5:
		if gameover_fall != true:
			gameover_fall = true
			UtilsSound.play_sound("res://gameover/death.wav", 2.0)
			%Jawsh.gravity_scale = 12.0
			$Jawsh/SpringArmPivot.frozen = true
	if %Jawsh.global_position.y < -80:
		get_tree().change_scene_to_file("res://gameover/gameover.tscn")
	var dolls_left_actual: float = %Dolls.get_child_count()
	if dolls_left != dolls_left_actual:
		if dolls_left_actual == 0:
			get_tree().change_scene_to_file("res://run_room.tscn")
		print(dolls_left_actual)
		%Ving.fury = 1.0 - (dolls_left_actual/total_dolls)
	dolls_left = dolls_left_actual
	
