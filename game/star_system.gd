extends Node2D

@onready var sprite := $StarColor
@onready var selection := $StarSelection
@onready var timer := $Timer
@onready var power_label := $Power

@export var team : GameData.TEAM = GameData.TEAM.NEUTRAL
var team_data = null

var power: int = 0 : set = set_power
var bridges := []


func _ready():
	team_data = GameData.get_team(team)
	if team_data.is_player:
		sprite.texture = team_data.texture


func set_power(new_power):
	power = new_power
	if power_label:
		power_label.text = str(power)


func _on_timer_timeout():
	for bridge in bridges:
		bridge.send_unit(team)

	power += 1
	timer.start(1.0 if team_data.is_player else 2.0)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_mask == 1:
			get_tree().call_group("ui_control", "star_click", self)

		elif event.button_mask == 2:
			get_tree().call_group("ui_control", "star_action", self)


func select():
	selection.visible = true


func unselect():
	selection.visible = false
