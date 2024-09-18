extends Control

var save_path = "user://arcade.txt"
var file = FileAccess.open(save_path, FileAccess.READ)
var secs = int(file.get_line())
var mins = int(file.get_line())
var Tsecs = int(file.get_line())
var Msecs = int(file.get_line())
var Mmins = int(file.get_line())
var MTsecs = int(file.get_line())

func _process(delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Arcade_Dead.tscn")

func _on_submit_pressed():
	if $Name.text != "":
		var username = $Name.text
		if OS.get_environment("USERNAME") == "olilee58":
			username = username + " (DEV)"
		elif OS.get_environment("USER") == "olilee58":
			username = username + " (DEV)"
		await Leaderboards.post_guest_score("tds-tds-arcade-rIc0", MTsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Arcade_Leaderboard.tscn")
	elif OS.has_environment("USERNAME"):
		var username = OS.get_environment("USERNAME")
		if username == "olilee58":
			username = "olilee58 (DEV)"
		await Leaderboards.post_guest_score("tds-tds-arcade-rIc0", MTsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Arcade_Leaderboard.tscn")
	elif OS.has_environment("USER"):
		var username = OS.get_environment("USER")
		if username == "olilee58":
			username = "olilee58 (DEV)"
		await Leaderboards.post_guest_score("tds-tds-arcade-rIc0", MTsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Arcade_Leaderboard.tscn")
