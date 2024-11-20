extends Node2D 

@export var highlight_color: Color = Color(1.0, 1.0, 1.0, 0.25)  # Highlight color
@export var highlight_thickness: float = 3.0                     # Outline thickness
@export var collider_size: Vector2 = Vector2(100, 100)           # Default collider size
@export var sprite : Sprite2D
@export var interactable : Interactable
@onready var shader_material = sprite.material
@onready var collision_shape = interactable.get_node("CollisionShape2D")


func _ready():
	# Debugging outputs
	print("[Debug] Sprite2D exists: ", sprite)
	print("[Debug] Shader material: ", shader_material)
	print("[Debug] CollisionShape2D exists: ", collision_shape)
	
	# Ensure the Sprite2D has a ShaderMaterial
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_color", highlight_color)
		shader_material.set_shader_parameter("line_thickness", 0.0)  
	else:
		print("Error: Material is not a ShaderMaterial.")

	# Configure the CollisionShape2D
	if collision_shape.shape is RectangleShape2D:
		collision_shape.shape.extents = collider_size / 2  # Set size dynamically
		print("[Debug] Collider size set to: ", collider_size)
	else:
		print("Error: CollisionShape2D does not use RectangleShape2D!")

func _on_interactable_player_enter() -> void:
	print("[Debug] Mouse entered the area")  
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", highlight_thickness)
		shader_material.set_shader_parameter("line_color", highlight_color)

func _on_interactable_player_exit() -> void:
	print("[Debug] Mouse exited the area") 
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", 0.0)
