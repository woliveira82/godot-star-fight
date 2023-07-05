extends ColorRect

@onready var bridges = $Bridges

var star_bridge = preload("res://game/star_bridge.tscn")
var star_selected: Node2D = null

 
func star_click(star):
	get_tree().call_group("stars", "unselect")
	star_selected = star
	star.select()


func star_action(star):
	if not star_selected or star_selected == star:
		return
	
	if not star_selected.team_data.is_player:
		get_tree().call_group("stars", "unselect")
		return

	if star_selected.bridges.has(star.position):
		get_tree().call_group("stars", "unselect")
		return

	_insert_bridge(star_selected, star.position)


func _insert_bridge(origin_star, destiny: Vector2):
	var new_bridge = star_bridge.instantiate()
	bridges.add_child(new_bridge)
	new_bridge.set_direction(origin_star.position, destiny)
	get_tree().call_group("stars", "unselect")
	origin_star.bridges.append(new_bridge)
