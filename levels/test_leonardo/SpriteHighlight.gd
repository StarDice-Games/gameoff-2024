extends Sprite2D

@onready var shader_material = self.material  # Reference to the ShaderMaterial

func _ready():
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", 0.0)  # Disable highlight by default
	else:
		print("Error: Material is not a ShaderMaterial.")

func _on_character_body_2d_mouse_entered():
	# Enable highlight
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", 3.0)  # Highlight thickness
		shader_material.set_shader_parameter("line_color", Color(1, 1, 0, 0.5))  # Yellow highlight
	else:
		print("Error: Material is not a ShaderMaterial.")

func _on_character_body_2d_mouse_exited():
	# Disable highlight
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", 0.0)  # Disable highlight
	else:
		print("Error: Material is not a ShaderMaterial.")
