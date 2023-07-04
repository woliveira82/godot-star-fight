extends ColorRect


var star_selected: Node2D = null

 
func star_click(star):
	get_tree().call_group("stars", "unselect")
	star_selected = star
	star.select()
	
	
