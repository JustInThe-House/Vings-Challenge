extends Node3D

@onready var jawsh := %Jawsh
@onready var dolls := %Dolls
@onready var camera_springarm := $Jawsh/SpringArmPivot
@onready var ving := %Ving
var dolls_collected: float = 0
var total_dolls: int
var dolls_left: int
@onready var CRT: ColorRect = $CRT
@onready var dolls_left_text := $DollsLeft
@onready var death_barrier := $DeathBarrier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play()
	total_dolls = dolls.get_child_count()
	dolls_left = total_dolls
	# REFACTOR TO BE CALLED PLUSHIES
	dolls_left_text.text = "Plushies Left: " + str(dolls_left)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var dolls_left_actual: int = dolls.get_child_count()
	if dolls_left != dolls_left_actual:
		if dolls_left_actual == 0:
			get_tree().change_scene_to_file("res://rooms/run_room.tscn")
		ving.fury = 1.0 - (dolls_left_actual/float(total_dolls))
	dolls_left = dolls_left_actual
	dolls_left_text.text = "Plushies Left: " + str(dolls_left)
	
	var distance: float = jawsh.position.distance_to(ving.position)
	if distance < 80.0 and SaveManager.save_data.shaders:
		CRT.material.set("shader_parameter/alpha", 0.6 * (1 - distance/80.0))
		CRT.material.set("shader_parameter/vinnette_outer_radius", 0.2 + 0.5 * (distance/80.0))
		pass
	


func _on_death_barrier_body_entered(body: Node3D) -> void:
	if body == jawsh:
		UtilsSound.play_sound("res://gameover/death.wav", 2.0)
		jawsh.gravity_scale = 12.0
		camera_springarm.frozen = true
		await get_tree().create_timer(1.1, true, true, false).timeout
		# for some reason doing it based on physics time was the answer? 
		# i guess, since the timer creation is based on collision (jawsh and death barrier)
		get_tree().change_scene_to_file(Universal.game_over_scene)
