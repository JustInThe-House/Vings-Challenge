extends Node3D

@onready var jawsh := %Jawsh
@onready var plushies := %Plushies
@onready var camera_springarm := $Jawsh/SpringArmPivot
@onready var ving := %Ving
var plushies_collected: float = 0
var total_plushies: int
@onready var plushies_left_text := $PlushiesLeft
var plushies_left: int
@onready var CRT: ColorRect = $CRT
const CRT_effect_distance := 80.0
@onready var death_barrier := $DeathBarrier

func _ready() -> void:
	Music.play()
	total_plushies = plushies.get_child_count()
	plushies_left = total_plushies
	# REFACTOR TO BE CALLED PLUSHIES
	plushies_left_text.text = "Plushies Left: " + str(plushies_left)
	
func _process(_delta: float) -> void:
	var plushies_left_actual: int = plushies.get_child_count()
	if plushies_left != plushies_left_actual:
		if plushies_left_actual == 0:
			get_tree().change_scene_to_file("res://rooms/run_room.tscn")
		ving.fury = 1.0 - (plushies_left_actual/float(total_plushies))
	plushies_left = plushies_left_actual
	plushies_left_text.text = "Plushies Left: " + str(plushies_left)
	
	var distance: float = jawsh.position.distance_to(ving.position)
	if distance < CRT_effect_distance and SaveManager.save_data.shaders:
		CRT.material.set("shader_parameter/alpha", 0.6 * (1 - distance/CRT_effect_distance))
		CRT.material.set("shader_parameter/vinnette_outer_radius", 0.2 + 0.5 * (distance/CRT_effect_distance))
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
		
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_menu = preload("res://menu/pause/pause_menu.tscn").instantiate()
		Universal.game_paused.emit()
		add_child(pause_menu)
