extends CharacterBody2D

@export var highlight_color: Color = Color(1.0, 1.0, 1.0, 0.25)  # Default highlight color
@export var highlight_thickness: float = 3.0                     # Default line thickness
@onready var sprite = $Sprite2D
@onready var shader_material = sprite.material

func _ready():
	# Debugging outputs
	print("[Debug] Sprite2D node exists: ", sprite)
	print("[Debug] Shader material: ", shader_material)

	# Ensure the Sprite2D has a ShaderMaterial
	if shader_material is ShaderMaterial:
		print("[Debug] ShaderMaterial found, setting initial parameters.")
		shader_material.set_shader_parameter("line_color", highlight_color)
		shader_material.set_shader_parameter("line_thickness", 0.0)
	else:
		print("[Error] Sprite2D does not have a ShaderMaterial!")

	# Connect signals and confirm connection success
	var mouse_entered_result = connect("mouse_entered", Callable(self, "_on_character_body_2d_mouse_entered"))
	var mouse_exited_result = connect("mouse_exited", Callable(self, "_on_character_body_2d_mouse_exited"))
	print("[Debug] mouse_entered connected: ", mouse_entered_result)
	print("[Debug] mouse_exited connected: ", mouse_exited_result)


func _on_character_body_2d_mouse_entered() -> void:
	print("[Debug] Signal triggered: mouse_entered")
	if shader_material is ShaderMaterial:
		print("[Debug] Updating shader for mouse entered.")
		shader_material.set_shader_parameter("line_thickness", highlight_thickness)
		shader_material.set_shader_parameter("line_color", highlight_color)
	else:
		print("[Error] ShaderMaterial is missing in _on_character_body_2d_mouse_entered!")


func _on_character_body_2d_mouse_exited() -> void:
	print("[Debug] Signal triggered: mouse_exited")
	if shader_material is ShaderMaterial:
		print("[Debug] Resetting shader for mouse exited.")
		shader_material.set_shader_parameter("line_thickness", 0.0)
	else:
		print("[Error] ShaderMaterial is missing in _on_character_body_2d_mouse_exited!")
