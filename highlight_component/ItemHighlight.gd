extends Area2D 

@export var highlight_color: Color = Color(1.0, 1.0, 1.0, 0.25)  # Highlight color
@export var highlight_thickness: float = 3.0                     # Outline thickness
@export var collider_size: Vector2 = Vector2(100, 100)           # Default collider size
@export var sprite : Sprite2D
#@export var interactable : Interactable
@export var shader : ShaderMaterial

#@onready var shader_material = sprite.material
#@onready var collision_shape = interactable.get_node("CollisionShape2D")


func _ready():
	# Debugging outputs
	print("[Debug] Sprite2D exists: ", sprite)
	print("[Debug] Shader material: ", shader)
	#print("[Debug] CollisionShape2D exists: ", collision_shape)
	
	if shader is ShaderMaterial:
		shader.set_shader_parameter("line_color", highlight_color)
		shader.set_shader_parameter("line_thickness", 0.0)  
	else:
		print("Error: Material is not a ShaderMaterial.")
	
	# Ensure the Sprite2D has a ShaderMaterial
	if sprite != null:
		sprite.material = shader

func interactable_player_enter() -> void:
	print("[Debug] Mouse entered the area")  
	shader.set_shader_parameter("line_thickness", highlight_thickness)
	shader.set_shader_parameter("line_color", highlight_color)

func interactable_player_exit() -> void:
	print("[Debug] Mouse exited the area")
	shader.set_shader_parameter("line_thickness", 0.0)


func _on_area_entered(area: Area2D) -> void:
	var father = area.get_parent()
	if father == null:
		return
	if father is Player :
		shader.set_shader_parameter("line_thickness", highlight_thickness)
		shader.set_shader_parameter("line_color", highlight_color)


func _on_area_exited(area: Area2D) -> void:
	var father = area.get_parent()
	if father == null:
		return
	if father is Player :
		shader.set_shader_parameter("line_thickness", 0.0)
	pass # Replace with function body.
