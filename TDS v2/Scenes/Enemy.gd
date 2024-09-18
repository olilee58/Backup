extends Area2D

var speed = 1
var player = Vector2.ZERO
var mouse = 0
var bullet = 6
var x = 0
var y = 0
var reloading = 0

func _ready():
	randomize()
	
# Set spawn of enemy when killed
func _process(_delta):
	if y < -1600:
		y = randi_range(player.y + 1500, player.y - 1500)
	if y > -30:
		y = randi_range(player.y + 1500, player.y - 1500)
	if x > -30:
		x = randi_range(player.x + 1500, player.x - 1500)
	if x < -43200:
		x = randi_range(player.x + 1500, player.x - 1500)
	if x < (player.x + 1000):
		x = randi_range(player.x + 1500, player.x - 1500)
	if x > (player.x - 1000):
		x = randi_range(player.x + 1500, player.x - 1500)
	x = randi_range(player.x + 1500, player.x - 1500)
	y = randi_range(player.y + 1500, player.y - 1500)
	speed += 0.0001
	
# Enemy tracks and moves toward player and keep in range
func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		player = area.global_position
		while true:
			look_at(player)
			position = position.move_toward(player, speed)
			player = area.global_position
			await get_tree().create_timer(0.016).timeout
			if position.x < (player.x - 1900) or position.x > (player.x + 1900):
				position.x = x
				position.y = y

func _on_mouse_entered():
	mouse = 1

func _on_mouse_exited():
	mouse = 0

# Keep track of bullet count and kill enemy when shot
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_shoot") and bullet > 0 and reloading == 0:
		bullet -= 1
		if mouse == 1:
			$Hit.play()
			$Hit.pitch_scale = randf_range(0.5, 1.5)
			position.x = x
			position.y = y
			
	# Keep track of reloading
	if Input.is_action_just_pressed("ui_reload"):
		if not reloading == 1:
			reloading = 1
			await get_tree().create_timer(1.4).timeout
			reloading = 0
			bullet = 6


func _on_area_entered(area):
	if area.is_in_group("NoZ"):
		position.x = x
		position.y = y
	if area.is_in_group("Player"):
		position.x = x
		position.y = y
