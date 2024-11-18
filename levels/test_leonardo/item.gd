extends Node2D

@export var item_resource: ItemResource  

func _ready() -> void:
	if item_resource:
		print(item_resource.item_id)
		

func _process(delta: float) -> void:
	pass
