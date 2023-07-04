extends Node2D

@onready var line = $Line2D


func set_direction(origin: Vector2, destiny: Vector2):
	line.add_point(origin)
	line.add_point(destiny)


func get_direction():
	return line.points
