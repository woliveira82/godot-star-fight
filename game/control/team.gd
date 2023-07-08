extends Node

const _RED_STAR = preload("res://assets/red.png")
const _BLUE_STAR = preload("res://assets/blue.png")
const _GRAY_STAR = preload("res://assets/gray.png")

var is_player: bool = false
var texture = _GRAY_STAR


func set_team(color: String, player: bool):
	is_player = player
	match color:
		"gray":
			texture = _GRAY_STAR
		"blue":
			texture = _BLUE_STAR
		"red":
			texture = _RED_STAR
		_:
			texture = _GRAY_STAR
