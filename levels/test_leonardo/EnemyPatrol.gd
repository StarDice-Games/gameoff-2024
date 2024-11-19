extends Area2D

var speed = 20
var fov_up
var fov_down
var fov_left
var fov_right
var initial_direction = "right" 
var is_resetting = false  

func _ready():
	fov_up = $FieldOfViewUp
	fov_down = $FieldOfViewDown
	fov_left = $FieldOfViewLeft
	fov_right = $FieldOfViewRight

	fov_up.visible = false
	fov_down.visible = false
	fov_left.visible = false
	fov_right.visible = false

	set_fov(initial_direction)
	print("Initial FOV set to:", initial_direction)

func set_fov(dir: String):
	fov_up.visible = false
	fov_down.visible = false
	fov_left.visible = false
	fov_right.visible = false

	match dir:
		"up":
			fov_up.visible = true
		"down":
			fov_down.visible = true
		"left":
			fov_left.visible = true
		"right":
			fov_right.visible = true

	print("FOV updated to:", dir)  

func _on_path_reset():
	print("Path reset detected in EnemyPatrol")  
	is_resetting = true  
	set_fov(initial_direction)  
	await get_tree().create_timer(0.1).timeout  
	is_resetting = false 

func _on_EnemyPatrol_area_entered(area: Area2D):
	if is_resetting:
		return

	if area.is_in_group("Checkpoints"):
		print("Checkpoint encountered with direction:", area.direction)
		set_fov(area.direction)
