extends Control

var save_path = "user://variable.txt"
var file = FileAccess.open(save_path, FileAccess.READ)
var secs = int(file.get_line())
var mins = int(file.get_line())
var Tsecs = int(file.get_line())
var Fsecs = int(file.get_line())
var Fmins = int(file.get_line())
var FTsecs = int(file.get_line())

func _process(_delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Win.tscn")

# Get name of player to put on leaderboard
# BONUS: If it's my score it says dev
func _on_submit_pressed():
	if $Name.text != "":
		var username = $Name.text
		if OS.get_environment("USERNAME") == "olilee58":
			username = username + " (DEV)"
		elif OS.get_environment("USER") == "olilee58":
			username = username + " (DEV)"
		await Leaderboards.post_guest_score("tds-tds-VjVF", FTsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
	elif OS.has_environment("USERNAME"):
		var username = OS.get_environment("USERNAME")
		if username == "olilee58":
			username = "olilee58 (DEV)"
		await Leaderboards.post_guest_score("tds-tds-VjVF", FTsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
	elif OS.has_environment("USER"):
		var username = OS.get_environment("USER")
		if username == "olilee58":
			username = "olilee58 (DEV)"
		await Leaderboards.post_guest_score("tds-tds-VjVF", FTsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
