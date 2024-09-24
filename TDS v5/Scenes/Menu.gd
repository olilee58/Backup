extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game_Choice.tscn")

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Scenes/Controls.tscn")

func _process(_delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()


func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://Scenes/Leaderboard_Choice.tscn")


func _on_quit_pressed():
	get_tree().quit()
