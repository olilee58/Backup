extends Control

func _process(_delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
