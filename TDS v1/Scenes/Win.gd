extends Control

var save_path = "user://variable.txt"
var file = FileAccess.open(save_path, FileAccess.READ)
var secs = int(file.get_line())
var mins = int(file.get_line())
var Tsecs = int(file.get_line())
var Fsecs = int(file.get_line())
var Fmins = int(file.get_line())
var FTsecs = int(file.get_line())

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	
func _ready():
	if Tsecs == FTsecs:
		$Message.text = "You Win\nNew Best Time: " + "%01d:" % mins + "%02d" % secs
	else:
		$Message.text = "You Win\nYour Time: " + "%01d:" % mins + "%02d" % secs

func _on_submit_pressed():
	if OS.has_environment("USERNAME"):
		var username = OS.get_environment("USERNAME")
		if username == "olilee58":
			username = "olilee58 (DEV)"
		await Leaderboards.post_guest_score("tds-tds-VjVF", Tsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
	elif OS.has_environment("USER"):
		var username = OS.get_environment("USER")
		if username == "olilee58":
			username = "olilee58 (DEV)"
		await Leaderboards.post_guest_score("tds-tds-VjVF", Tsecs, username)
		get_tree().change_scene_to_file("res://Scenes/Leaderboard.tscn")
	else:
		$Submit.text = "ERROR"
		await get_tree().create_timer(3).timeout
		$Submit.text = "Submit Score"
