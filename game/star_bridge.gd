extends Node2D

var unity = preload("res://game/unit.tscn")

@onready var line = $Line2D
@onready var units = $Units

var team: GameData.TEAM
var origin: Node2D = null
var destiny: Node2D = null


func set_bridge(new_team: GameData.TEAM, origin_star, destiny_star):
	team = new_team
	origin = origin_star
	destiny = destiny_star

	line.add_point(Vector2.ZERO)
	line.add_point(destiny.position - origin.position)
	line.default_color = GameData.get_team(team).rgb


func get_units():
	return units.get_children()


func add_and_revert_units(units_moving):
	for unit in units_moving:
		send_unit(unit.team, unit.force, unit.global_position - origin.position)


func send_unit(unit_team: GameData.TEAM, attack_force := 1, new_position := Vector2.ZERO):
	var new_unity = unity.instantiate()
	units.add_child(new_unity)
	new_unity.set_unit(unit_team, origin, destiny, attack_force, new_position)
