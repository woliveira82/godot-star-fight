extends ColorRect

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

	star_selected.add_bridge_to(star)
	get_tree().call_group("stars", "unselect")
