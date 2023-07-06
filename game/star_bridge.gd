extends Node2D

var unity = preload("res://game/unit.tscn")

@onready var line = $Line2D
@onready var path = $Path2D

var origin: Node2D = null
var destiny: Node2D = null


func set_direction(origin_star, destiny_star):
	origin = origin_star
	destiny = destiny_star

	line.add_point(origin.position)
	line.add_point(destiny.position)

	path.curve.add_point(origin.position)
	path.curve.add_point(destiny.position)


func send_unit(team: GameData.TEAM, attack_force := 1):
	var new_unity = unity.instantiate()
	path.add_child(new_unity)
	new_unity.set_unit(team, origin, attack_force)
