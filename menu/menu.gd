extends Control

#maybe keep track of menu state? not needed, but could be useful when adding additional menus. 
#though it would mean more complex button work.
@onready var animation_player := $AnimationPlayer

func _ready() -> void:
	$"Actions & Info/MainMenu/Play".grab_focus.call_deferred()
	
	if SaveManager.save_data.beat_game == true:
		$"Actions & Info/WinStar".visible = true
	else:
		$"Actions & Info/WinStar".visible = false
	
	if not SaveManager.save_data.first_time_playing:
		Music.play()
		if not Universal.played_once:
			animation_player.play("titlecard")
		else:
			if SaveManager.save_data.beat_game and not SaveManager.save_data.first_win:
				animation_player.play("titlecard")
				SaveManager.save_data.first_win = true
			else:
				animation_player.play("finish")

	else:
		print("FIRST TIME")
		SaveManager.save_data.first_time_playing = false
		SaveManager.write_to_save()
		animation_player.play("finish_flash")
