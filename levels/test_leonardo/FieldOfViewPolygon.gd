extends Polygon2D

# Set direction and reset polygon to avoid unintended transformations
func set_direction(direction: String):
	var new_polygon = []  # Temporary variable to avoid unintended scaling

	match direction:
		"left":
			new_polygon = [
				Vector2(0, 0),
				Vector2(-30, 60),
				Vector2(30, 60)
			]
		"right":
			new_polygon = [
				Vector2(0, 0),
				Vector2(30, 60),
				Vector2(-30, 60)
			]
		"up":
			new_polygon = [
				Vector2(0, 0),
				Vector2(-60, -30),
				Vector2(60, -30)
			]
		"down":
			new_polygon = [
				Vector2(0, 0),
				Vector2(-60, 30),
				Vector2(60, 30)
			]

	# Assign the new shape explicitly
	polygon = new_polygon
