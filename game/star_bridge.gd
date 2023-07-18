extends Node2D

var unity = preload("res://game/unit.tscn")

@onready var line := $Line2D
@onready var units := $Units
@onready var ui_collision_shape := $UIArea/CollisionShape2D

var team: GameData.TEAM
var origin: Node2D = null
var destiny: Node2D = null
var active := true : set = set_active


func set_bridge(new_team: GameData.TEAM, origin_star, destiny_star):
	team = new_team
	origin = origin_star
	destiny = destiny_star

	line.add_point(Vector2.ZERO)
	line.add_point(destiny.position - origin.position)
	line.default_color = GameData.get_team(team).rgb
	
	var bridge_vector = destiny_star.position - origin_star.position
	ui_collision_shape.shape.size.x = bridge_vector.length() - 40.0
	ui_collision_shape.position = bridge_vector / 2
	ui_collision_shape.rotation = bridge_vector.angle()


func set_active(new_active: bool):
	line.visible = new_active
	active = new_active


func get_units():
	return units.get_children()


func add_and_revert_units(units_moving):
	for unit in units_moving:
		send_unit(unit.team, unit.force, unit.global_position - origin.position)


func send_unit(unit_team: GameData.TEAM, attack_force := 1, new_position := Vector2.ZERO):
	if active:
		var new_unity = unity.instantiate()
		units.add_child(new_unity)
		new_unity.set_unit(unit_team, origin, destiny, attack_force, new_position)
	
	else:
		if units.get_children() == []:
			queue_free()


func _on_ui_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and team == GameData.TEAM.PLAYER:
		if event.button_mask == 2:
			active = false
