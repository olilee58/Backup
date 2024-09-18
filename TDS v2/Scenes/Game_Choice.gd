extends Control

func _on_main_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_arcade_pressed():
	get_tree().change_scene_to_file("res://Scenes/Arcade.tscn")

func _process(delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
