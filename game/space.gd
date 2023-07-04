extends ColorRect

@onready var bridges = $Bridges

var star_bridge = preload("res://game/star_bridge.tscn")
var star_selected: Node2D = null
var bridges_directions = {}

 
func star_click(star):
	get_tree().call_group("stars", "unselect")
	star_selected = star
	star.select()


func star_action(star):
	if not star_selected or star_selected == star:
		return
	
	if not star_selected.player:
		get_tree().call_group("stars", "unselect")
		return

	var origin = star_selected.position
	var destiny = star.position
	if _bridges_contains(origin, destiny):
		get_tree().call_group("stars", "unselect")
		return

	_insert_bridge(origin, destiny)


func _bridges_contains(origin: Vector2, destiny: Vector2) -> bool:
	if not bridges_directions.has(origin):
		return false
	
	return bridges_directions[origin].has(destiny)


func _insert_bridge(origin: Vector2, destiny: Vector2):
	var new_bridge = star_bridge.instantiate()
	bridges.add_child(new_bridge)
	new_bridge.set_direction(origin, destiny)
	get_tree().call_group("stars", "unselect")
	if bridges_directions.has(origin):
		bridges_directions[origin].append(destiny)
	
	else:
		bridges_directions.merge({origin: [destiny]})
