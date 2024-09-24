extends Control

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _process(delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()
