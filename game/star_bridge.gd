extends Node2D

var unity = preload("res://game/unit.tscn")

@onready var line = $Line2D
@onready var path = $Path2D

var team: GameData.TEAM
var origin: Node2D = null
var destiny: Node2D = null


func set_bridge(new_team: GameData.TEAM, origin_star, destiny_star):
	team = new_team
	origin = origin_star
	destiny = destiny_star

	line.add_point(Vector2.ZERO)
	line.add_point(destiny.position - origin.position)

	path.curve.add_point(Vector2.ZERO)
	path.curve.add_point(destiny.position - origin.position)


func send_unit(unit_team: GameData.TEAM, attack_force := 1):
	var new_unity = unity.instantiate()
	path.add_child(new_unity)
	new_unity.set_unit(unit_team, origin, attack_force)
