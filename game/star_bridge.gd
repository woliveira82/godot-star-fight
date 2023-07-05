extends Node2D

var unity = preload("res://game/unit.tscn")

@onready var line = $Line2D
@onready var path = $Path2D


func set_direction(origin: Vector2, destiny: Vector2):
	line.add_point(origin)
	line.add_point(destiny)
	
	path.curve.add_point(origin)
	path.curve.add_point(destiny)


func send_unit(team: GameData.TEAM):
	var new_unity = unity.instantiate()
	path.add_child(new_unity)
	new_unity.set_unit(team)
