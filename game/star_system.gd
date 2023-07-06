extends Node2D

@onready var sprite := $StarColor
@onready var selection := $StarSelection
@onready var growth_timer := $GrowthTimer
@onready var attack_timer := $AttackTimer
@onready var power_label := $Power

@export var team : GameData.TEAM = GameData.TEAM.NEUTRAL
var team_data = null

@export var growth_speed := 2
@export var attack_speed := 2
@export var attack_force := 1
@export var max_power:= 30
var power:= 1 : set = set_power
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


func _on_growth_timer_timeout():
	power += 1
	growth_timer.start(growth_speed)


func _on_attack_timer_timeout():
	for bridge in _bridges:
		bridge.send_unit(team, attack_force)
	
	attack_timer.start(attack_speed)


func _on_ui_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_mask == 1:
			get_tree().call_group("ui_control", "star_click", self)

		elif event.button_mask == 2:
			get_tree().call_group("ui_control", "star_action", self)


func _on_star_area_area_entered(unit_area):
	if unit_area.team != team:
		power -= unit_area.force
		if power == 0:
			set_team(unit_area.team)
	
	elif unit_area.origin != self:
		power += unit_area.force
