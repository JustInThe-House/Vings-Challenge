extends Control

#maybe keep track of menu state? not needed, but could be useful when adding additional menus. 
#though it would mean more complex button work.
@onready var animation_player := $AnimationPlayer

func _ready() -> void:
	# connect signals between menus
	$"Actions & Info/MainMenu/Extra/Extra".pressed.connect($LevelsMenu._on_extra_pressed)
	
	$"Actions & Info/MainMenu/Play/Play".grab_focus.call_deferred()
	$CreditsMenu.visible = false
	#$LevelsMenu.visible = false
	$SettingsMenu.visible = false
	
	if SaveManager.save_data.beat_game == true:
		$"Actions & Info/WinStar".visible = true
	else:
		$"Actions & Info/MainMenu/Extra".visible = false
		$"Actions & Info/WinStar".visible = false
	
	if not SaveManager.save_data.first_time_playing:
		Music.play()
		if not Universal.played_once:
			animation_player.play("titlecard")
			$"Actions & Info/ControlsText".visible = true
		else:
			if SaveManager.save_data.beat_game and not SaveManager.save_data.first_win:
				animation_player.play("titlecard")
				SaveManager.save_data.first_win = true
			else:
				animation_player.play("finish")
			$"Actions & Info/ControlsText".visible = false

	else:
		print("FIRST TIME")
		#$"Actions & Info/ControlsText".visible = false
		SaveManager.save_data.first_time_playing = false
		SaveManager.write_to_save()
		animation_player.play("finish_flash")
