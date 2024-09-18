extends Control



func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	
func _ready():
	var save_path = "user://variable.txt"
	var file = FileAccess.open(save_path, FileAccess.READ)
	var secs = int(file.get_line())
	var mins = int(file.get_line())
	var Tsecs = int(file.get_line())
	var _Fsecs = int(file.get_line())
	var _Fmins = int(file.get_line())
	var FTsecs = int(file.get_line())
	if Tsecs == FTsecs:
		$Message.text = "You Win\nNew Best Time: " + "%01d:" % mins + "%02d" % secs
	else:
		$Message.text = "You Win\nYour Time: " + "%01d:" % mins + "%02d" % secs

func _on_submit_pressed():
	get_tree().change_scene_to_file("res://Scenes/submitter.tscn")
	
	
