extends Control

@export var icon_check : Texture2D
@export var icon_uncheck : Texture2D

@onready var label : Label = $Panel/Label
@onready var icon_rect : TextureRect = $Panel/TextureRect
@onready var counter : Label = $Panel/Counter

func set_ui(task : Task):
	counter.hide()
	if not task.counter_max == -1:
		counter.show()
		update_counter(task)
	
	label.text = task.description
	if task.complete:
		icon_rect.texture = icon_check
	else:
		icon_rect.texture = icon_uncheck
	

func update_counter(task: Task):
		counter.text = str(task.current_counter) + "/" + str(task.counter_max)
