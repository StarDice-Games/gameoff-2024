extends CharacterBody2D 

@onready var sprite = $Sprite2D  
@onready var shader_material = sprite.material  

func _ready():
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", 0.0)  
	else:
		print("Error: Material is not a ShaderMaterial.")

func _on_mouse_entered() -> void:
	print("Mouse entered the area")  
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", 3.0)
		shader_material.set_shader_parameter("line_color", Color(1, 1, 0, 0.5))


func _on_mouse_exited() -> void:
	print("Mouse exited the area") 
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("line_thickness", 0.0)
