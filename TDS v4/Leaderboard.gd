extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	$Sprite2D.global_position = get_global_mouse_position()
	$Darkness.global_position = get_global_mouse_position()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
