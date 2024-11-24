extends CharacterBody2D

@export var speed = 20
@onready var fov_up = $UpFov
@onready var fov_down = $DownFov
@onready var fov_left = $LeftFov
@onready var fov_right = $RightFov
@export var initial_direction = "right"
@export var path : PathFollow2D
@export var monolog : Array[DialogText]

@onready var caught = $Caught

var is_resetting = false
var path_direction = -1
var stop = false

func _ready():
	
	toggle_node(fov_up, false)
	toggle_node(fov_down, false)
	toggle_node(fov_left, false)
	toggle_node(fov_right, false)

	set_fov(initial_direction)
	print("Initial FOV set to:", initial_direction)
	
	caught.hide()
	EventSystem.cutscene_started.connect(enter_cutscene)
	EventSystem.cutscene_finished.connect(exit_cutscene)

func enter_cutscene():
	stop = true
	
func exit_cutscene():
	pass

func _process(delta: float) -> void:
	
	if stop :
		return
	
	if path != null:
		var progress = path.progress_ratio
		if progress >= 1:
			path_direction *= -1
		if progress <= 0:
			path_direction *= -1
		
	path.progress += speed * delta * path_direction
	
	pass

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

func detect_player(area: Area2D) -> void:
	var father = area.get_parent()
	
	if father == null:
		printerr("area has no father")
		return
	
	if father is Player:
		if father.in_shadow:
			return
		
		caught.show()
		stop = true
		EventSystem.cutscene_started.emit()
		if monolog != null and monolog.size() > 0:
			DialogueSystem.start_dialog(monolog)
