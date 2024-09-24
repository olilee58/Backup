extends Node2D

func _physics_process(_delta):
	if Input.is_action_just_pressed("Exit"):
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
