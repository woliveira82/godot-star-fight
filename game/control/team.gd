extends Node

const _RED_STAR = preload("res://assets/red.png")
const _BLUE_STAR = preload("res://assets/blue.png")
const _GRAY_STAR = preload("res://assets/gray.png")

var is_player: bool = false
var texture = _GRAY_STAR


func set_team(player: bool, color: String):
	is_player = player
	match color:
		"red":
			texture = _RED_STAR
		"blue":
			texture = _BLUE_STAR
		"gray":
			texture = _GRAY_STAR
		_:
			texture = _GRAY_STAR
