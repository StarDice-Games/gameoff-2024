extends CharacterBody2D

@export var speed = 20
@onready var fov_up = $UpFov
@onready var fov_down = $DownFov
@onready var fov_left = $LeftFov
@onready var fov_right = $RightFov
@export var initial_direction = "right"
var is_resetting = false

func _ready():
	
	toggle_node(fov_up, false)
	toggle_node(fov_down, false)
	toggle_node(fov_left, false)
	toggle_node(fov_right, false)

	set_fov(initial_direction)
	print("Initial FOV set to:", initial_direction)

func toggle_node(node:Node2D, enabled):
	if not enabled:
		node.hide()
		node.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		node.show()
		node.process_mode = Node.PROCESS_MODE_INHERIT

func set_fov(dir: String):
	toggle_node(fov_up, false)
	toggle_node(fov_down, false)
	toggle_node(fov_left, false)
	toggle_node(fov_right, false)

	match dir:
		"up":
			toggle_node(fov_up, true)
		"down":
			toggle_node(fov_down, true)
		"left":
			toggle_node(fov_left, true)
		"right":
			toggle_node(fov_right, true)

	print("FOV updated to:", dir)  

func _on_path_reset():
	print("Path reset detected in EnemyPatrol")  
	is_resetting = true  
	set_fov(initial_direction)  
	await get_tree().create_timer(0.1).timeout  
	is_resetting = false 

func _on_enemy_area_area_entered(area: Area2D) -> void:
	if is_resetting:
		return
		
	if area.is_in_group("Checkpoints") or area is Checkpoint:
		print("Checkpoint encountered with direction:", area.direction)
		set_fov(area.direction)
