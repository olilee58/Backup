extends CharacterBody2D

var speed = 1000
var friction = 0.1
var bullet = 6
var secs: int = 0
var mins: int = 0
var Mmins: int = 0
var Msecs: int = 0
var Tsecs: int = 0
var MTsecs: int = 0
var save_path = "user://arcade.txt"
var lives = 3
var reloading = 0
var time = 0

# Load save and keep track of time
func _ready():
	randomize()
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		Msecs = int(file.get_line())
		Mmins = int(file.get_line())
		MTsecs = int(file.get_line())

# Movement for player by recoil of weapon
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	$HUD/Ammo_Count.text = str(bullet)
	if Input.is_action_just_pressed("ui_shoot") and bullet > 0 and reloading == 0:
		velocity = (transform.x * -1 * speed) + velocity
		$Shot.play()
		$Shot.pitch_scale = randf_range(1, 2)
		bullet -= 1
		move_and_slide()
		if time == 0:
			time = 1
			timer()
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		move_and_slide()
	
	# Reloading
	if Input.is_action_just_pressed("ui_reload"):
		if not reloading == 1:
			reloading = 1
			$Reload.play()
			$Reload.pitch_scale = randf_range(1, 1.5)
			await get_tree().create_timer(1.4).timeout
			reloading = 0
			bullet = 6

# Player dies when touching enemy, deals with terrain, and saves time on win
func _on_area_2d_area_entered(area):
	if area.is_in_group("Death"):
		$Bite.play()
		$Bite.pitch_scale = randf_range(0.5, 1.5)
		if lives == 1:
			var file = FileAccess.open(save_path, FileAccess.WRITE)
			file.store_line(str(secs))
			file.store_line(str(mins))
			file.store_line(str(Tsecs))
			if MTsecs == 0 or MTsecs < Tsecs:
				Mmins = mins
				Msecs = secs
				MTsecs = Tsecs
				file.store_line(str(Msecs))
				file.store_line(str(Mmins))
				file.store_line(str(MTsecs))
			get_tree().change_scene_to_file("res://Scenes/Arcade_Dead.tscn")
		elif lives == 2:
			$HUD/Health_2.animation = "Dead"
			lives = 1
		elif lives == 3:
			$HUD/Health_3.animation = "Dead"
			lives = 2
	if area.is_in_group("Mud"):
		friction = 0.2
	if area.is_in_group("Ice"):
		friction = 0.05

func _on_area_2d_area_exited(area):
	if area.is_in_group("Mud") or area.is_in_group("Ice"):
		friction = 0.1

func timer():
	while true:
		$HUD/Time.text = "%01d:" % mins + "%02d" % secs
		$HUD/Longest_Time.text = "Longest Time:\n" + "%01d:" % Mmins + "%02d" % Msecs
		await get_tree().create_timer(1.0).timeout
		secs += 1
		Tsecs += 1
		if secs >= 60:
			mins += 1
			secs -= 60

func _on_bgm_finished():
	$BGM.play()
