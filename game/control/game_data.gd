extends Node

const team = preload("res://game/control/team.gd")


enum TEAM {
	PLAYER,
	NEUTRAL,
	TEAM_1,
}

var teams := {
	TEAM.PLAYER: set_team("blue", true),
	TEAM.NEUTRAL: team.new(),
	TEAM.TEAM_1: set_team("red"),
}


func set_team(color: String, player := false):
	var new_team = team.new()
	new_team.set_team(color, player)
	return new_team


func get_team(team_value: TEAM):
	return teams[team_value]
