extends CharacterBody2D

@export var SPEED = 300.0
@export var interact_distance = 100

@onready var ray_cast = $RayCast2D

var raycast_target : Vector2

@onready var animation_tree: AnimationTree = $AnimationTree

var last_facing_dir := Vector2(0, -1)

@export_category("Audio")
@export var footstep : AudioStream

func _process(delta: float) -> void:
	
	ray_cast.target_position = raycast_target
	
	if Input.is_action_just_pressed("interact") :
		if ray_cast.is_colliding():
			var area_collider = ray_cast.get_collider()
			if area_collider != null and area_collider is Interactable:
				area_collider.interact()

func _physics_process(delta: float) -> void:

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction := Input.get_axis("left", "right")
	var y_direction := Input.get_axis("up", "down")
	#if x_direction != 0 or y_direction != 0:
	velocity = Vector2(x_direction, y_direction) * SPEED
	
	if x_direction != 0 or y_direction != 0 :
		raycast_target = Vector2(x_direction, y_direction) * interact_distance
	
	velocity.move_toward(Vector2.ZERO, SPEED)
	
	#Animazione
	var idle = !velocity
	
	if !idle:
		last_facing_dir = velocity.normalized()
	
	animation_tree.set("parameters/conditions/idle", idle)
	animation_tree.set("parameters/conditions/walk", !idle)
	
	animation_tree.set("parameters/Walk/blend_position", last_facing_dir)
	animation_tree.set("parameters/Idle/blend_position", last_facing_dir)
	
	#suono passi
	if velocity.length() != 0:
		if $Timer.time_left <= 0:
			AudioSystem.play(footstep) 
			$Timer.start(0.43)

	move_and_slide()
