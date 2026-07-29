## This is a GDscript Node wich gets automatically added as Autoload while installing the addon.
## 
## It can run in the background to comunicate with Discord.
## You don't need to use it. If you remove it make sure to run [code]DiscordRPC.run_callbacks()[/code] in a [code]_process[/code] function.
##
## @tutorial: https://github.com/vaporvee/discord-rpc-godot/wiki
extends Node

func _ready() -> void:
	DiscordRPC.app_id = 1529508561351344279 # Application ID
	DiscordRPC.details = "Made by Kino Productions"
	DiscordRPC.state = "what is this thing"
	DiscordRPC.large_image = "drega" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "holy shit"
	DiscordRPC.small_image = "drega" # Image key from "Art Assets"
	DiscordRPC.small_image_text = "its dream"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	#DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh() # Always refresh after changing the values!
pass

func  _process(_delta) -> void:
	DiscordRPC.run_callbacks()
