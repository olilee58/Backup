extends Control

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/Arcade.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _ready():
	var save_path = "user://arcade.txt"
	var file = FileAccess.open(save_path, FileAccess.READ)
	var secs = int(file.get_line())
	var mins = int(file.get_line())
	var Tsecs = int(file.get_line())
	var _Msecs = int(file.get_line())
	var _Mmins = int(file.get_line())
	var MTsecs = int(file.get_line())
	if Tsecs == MTsecs:
		$Message.text = "You Died\nNew Best Time: " + "%01d:" % mins + "%02d" % secs
	else:
		$Message.text = "You Died\nYour Time: " + "%01d:" % mins + "%02d" % secs

func _process(_delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()
	
func _on_submit_pressed():
	get_tree().change_scene_to_file("res://Scenes/arcade_submitter.tscn")
