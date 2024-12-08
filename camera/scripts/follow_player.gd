extends Node2D

@export var speed = 300.0
@export var player_ref : CharacterBody2D

@onready var camera_body : CharacterBody2D = $CharacterBody2D

func _physics_process(delta: float) -> void:
	
	if player_ref == null:
		player_ref = %Player
	
	if player_ref == null:
		printerr("Missing player ref for camera")
		return
	
	#var distance : float = position.distance_to(player_ref.position)
	#var direction : Vector2 = camera_body.global_position.direction_to(player_ref.global_position)
	#
	#velocity = direction * speed	
	#velocity.move_toward(Vector2.ZERO, speed)
	var player_pos = player_ref.global_position
	var body_pos = camera_body.global_position
	
	camera_body.global_position = camera_body.global_position.move_toward(player_ref.global_position, speed)
	camera_body.move_and_slide() #needs to collide
