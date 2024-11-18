extends PathFollow2D

var speed = 20
@onready var enemy_patrol = $EnemyPatrol  
signal path_reset 

func _ready():
	progress_ratio = 0.0 
	connect("path_reset", Callable(enemy_patrol, "_on_path_reset")) 

func _process(delta: float) -> void:
	progress_ratio += speed * delta * 0.01
	if progress_ratio >= 1.0:
		progress_ratio = 0.0 
		print("Emitting path_reset signal") 
		emit_signal("path_reset")  
