extends Area2D 

@export var highlight_color: Color  # Highlight color
@export var sprite : Sprite2D
#@export var interactable : Interactable
@export var shader : ShaderMaterial

signal sprite_changed
#@onready var shader_material = sprite.material
#@onready var collision_shape = interactable.get_node("CollisionShape2D")


func _ready():
	# Debugging outputs
	print("[Debug] Sprite2D exists: ", sprite)
	print("[Debug] Shader material: ", shader)
	#print("[Debug] CollisionShape2D exists: ", collision_shape)
	
	if shader is ShaderMaterial:
		shader.set_shader_parameter("color",  "#ffffff00")
	else:
		print("Error: Material is not a ShaderMaterial.")
	
	if TriggersSystem.check_trigger("place_npc", false):
		shader.set_shader_parameter("color",  "#ffffff00")
	
	if sprite != null:
		sprite.material = shader

func interactable_player_enter() -> void:
	print("[Debug] Mouse entered the area")  
		# Ensure the Sprite2D has a ShaderMaterial
	if TriggersSystem.check_trigger("place_npc", true):
		shader.set_shader_parameter("color", highlight_color)

func interactable_player_exit() -> void:
	print("[Debug] Mouse exited the area")
	shader.set_shader_parameter("color",  "#ffffff00")


func _on_area_entered(area: Area2D) -> void:
	var father = area.get_parent()
	if father == null:
		return
	if father is Player and TriggersSystem.check_trigger("place_npc", true):
		shader.set_shader_parameter("color", highlight_color)


func _on_area_exited(area: Area2D) -> void:
	var father = area.get_parent()
	if father == null:
		return
	if father is Player:
		shader.set_shader_parameter("color", "#ffffff00")
	pass # Replace with function body.


func _on_sprite_changed(sprite_to_change: Sprite2D) -> void:
	sprite = sprite_to_change

	if sprite != null:
		sprite.material = shader
