extends CharacterBody2D

var speed = 1000
var friction = 0.1
var bullet = 6
var secs: int = 0
var mins: int = 0
var Fmins: int = 0
var Fsecs: int = 0
var Tsecs: int = 0
var FTsecs: int = 0
var save_path = "user://variable.txt"
var lives = 3
var reloading = 0
var time = 0
var b = 0

# Load save and keep track of time
func _ready():
	randomize()
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		secs = int(file.get_line())
		mins = int(file.get_line())
		Tsecs = int(file.get_line())
		Fsecs = int(file.get_line())
		Fmins = int(file.get_line())
		FTsecs = int(file.get_line())
		secs = 0
		mins = 0
		Tsecs = 0

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
		if b == 0:
			$Bullet.global_position = position.move_toward(get_global_mouse_position(), 1000)
			b = 1
			await get_tree().create_timer(0.1).timeout
			$Bullet.global_position = $SBullet.global_position
		if b == 1:
			$Bullet2.global_position = position.move_toward(get_global_mouse_position(), 1000)
			b = 2
			await get_tree().create_timer(0.1).timeout
			$Bullet2.global_position = $SBullet.global_position
		if b == 2:
			$Bullet3.global_position = position.move_toward(get_global_mouse_position(), 1000)
			b = 0
			await get_tree().create_timer(0.1).timeout
			$Bullet3.global_position = $SBullet.global_position
		if time == 0:
			time = 1
			timer()
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		move_and_slide()
	
	# Reloading
	if Input.is_action_just_pressed("ui_reload") or bullet == 0:
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
			get_tree().change_scene_to_file("res://Scenes/Dead.tscn")
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
	if area.is_in_group("NoZ"):
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_line(str(secs))
		file.store_line(str(mins))
		file.store_line(str(Tsecs))
		if FTsecs == 0 or FTsecs > Tsecs:
			Fmins = mins
			Fsecs = secs
			FTsecs = Tsecs
		file.store_line(str(Fsecs))
		file.store_line(str(Fmins))
		file.store_line(str(FTsecs))
		get_tree().change_scene_to_file("res://Scenes/Win.tscn")

func _on_area_2d_area_exited(area):
	if area.is_in_group("Mud") or area.is_in_group("Ice"):
		friction = 0.1

func timer():
	while true:
		$HUD/Time.text = "%01d:" % mins + "%02d" % secs
		$HUD/Fastest_Time.text = "Fastest Time:\n" + "%01d:" % Fmins + "%02d" % Fsecs
		await get_tree().create_timer(1.0).timeout
		secs += 1
		Tsecs += 1
		if secs >= 60:
			mins += 1
			secs -= 60

func _on_bgm_finished():
	$BGM.play()
