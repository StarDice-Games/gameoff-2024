extends Node2D

#@export var links : Array[SceneLink]
var links = {}
@export var player_ref : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#load links based on the children of the node
	if get_child_count() < 0:
		return
	
	for child in get_children():
		links[child.name] = child.position
	
	var last_link : String = GameState.last_player_link_id
	
	#manage the player by unique name
	if player_ref == null:
		player_ref = %Player
	
	if last_link != null and player_ref != null:
		if links.has(last_link):
			var link_pos = links[last_link]
			if link_pos != null:
				%Player/Camera2D.position_smoothing_enabled = false
				player_ref.global_position = link_pos
				if player_ref.has_method("change_player_sprite"):
					player_ref.direction = GameState.last_player_dir
	else:
		printerr("Player ref missing")
	

#func get_link_by_id(id : String) -> SceneLink:
	#for link in links:
		#if link.id == id:
			#return link
	#return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
