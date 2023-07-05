extends Node2D

@onready var sprite := $StarColor
@onready var selection := $StarSelection
@onready var timer := $Timer
@onready var power_label := $Power

@export var team : GameData.TEAM = GameData.TEAM.NEUTRAL
var team_data = null

@export var max_power: int = 30
var power: int = 1 : set = set_power
var _bridges := []


func _ready():
	team_data = GameData.get_team(team)
	sprite.texture = team_data.texture


func set_power(new_power):
	power = clamp(new_power, 0, max_power)
	if power_label:
		power_label.text = str(power)


func set_team(new_team: GameData.TEAM):
	team = new_team
	team_data = GameData.get_team(new_team)
	sprite.texture = team_data.texture


func select():
	selection.visible = true


func unselect():
	selection.visible = false


func add_bridge(star_bridge: Node2D) -> bool:
	if has_bridge_to(star_bridge.destiny):
		return false
	
	_bridges.append(star_bridge)
	return true


func has_bridge_to(destiny_star: Node2D) -> bool:
	for bridge in _bridges:
		if bridge.destiny == destiny_star:
			return true
	
	return false


func _on_timer_timeout():
	for bridge in _bridges:
		bridge.send_unit(team)

	power += 1
	timer.start(1.0 if team_data.is_player else 2.0)


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_mask == 1:
			get_tree().call_group("ui_control", "star_click", self)

		elif event.button_mask == 2:
			get_tree().call_group("ui_control", "star_action", self)


func _on_area_2d_2_area_entered(area):
	if area.team != team:
		power -= 1
		if power == 0:
			set_team(area.team)
