extends Node

const team = preload("res://game/control/team.gd")


enum TEAM {
	PLAYER,
	NEUTRAL,
	TEAM_1,
}

var teams := {
	TEAM.PLAYER: set_player_team("blue"),
	TEAM.NEUTRAL: team.new(),
}


func set_player_team(color: String):
	var player_team = team.new()
	player_team.set_team(true, color)
	# teams[TEAM.PLAYER] = player_team
	return player_team


func get_team(team: TEAM):
	return teams[team]
