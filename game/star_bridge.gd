extends Node2D

@onready var line = $Line2D
@onready var path = $Path2D


func set_direction(origin: Vector2, destiny: Vector2):
	line.add_point(origin)
	line.add_point(destiny)
	
	path.curve.add_point(origin)
	path.curve.add_point(destiny)
