extends Node

const _RED_STAR = preload("res://assets/red.png")
const _BLUE_STAR = preload("res://assets/blue.png")
const _GRAY_STAR = preload("res://assets/gray.png")

var is_player: bool = false
var texture = _GRAY_STAR
var rgb := Color(0.69, 0.69, 0.69, 0.4)


func set_team(color: String, player: bool):
	is_player = player
	match color:
		"gray":
			texture = _GRAY_STAR
		"blue":
			texture = _BLUE_STAR
			rgb = Color(0.278, 0.549, 0.749, 0.4)
		"red":
			texture = _RED_STAR
			rgb = Color(0.749, 0.278, 0.341, 0.4)
		_:
			texture = _GRAY_STAR
			rgb = Color(0.69, 0.69, 0.69, 0.4)
