extends Node2D

var star_bridge = preload("res://game/star_bridge.tscn")

@onready var sprite := $StarColor
@onready var selection := $StarSelection
@onready var growth_timer := $GrowthTimer
@onready var attack_timer := $AttackTimer
@onready var power_label := $Power
@onready var bridges := $Bridges

@export var team : GameData.TEAM = GameData.TEAM.NEUTRAL
var team_data = null

@export var growth_speed := 2
@export var attack_speed := 2
@export var attack_force := 1
@export var max_power:= 30
var power:= 1 : set = set_power


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


func add_bridge_to(star: Node2D):
	star.delete_bridge_to(self, team)
	
	var new_bridge = star_bridge.instantiate()
	bridges.add_child(new_bridge)
	new_bridge.set_bridge(team, self, star)


func delete_bridge_to(destiny_star, bridge_team: GameData.TEAM):
	for bridge in bridges.get_children():
		if bridge.destiny == destiny_star:
			bridge.queue_free()
		
#	var index = -1
#	for idx in range(0, _bridges.size()):
#		if _bridges[idx].destiny == destiny_star:
#			index = idx
#			break
#
#	if index >= 0:
#		_bridges[index].queue_free()
#		_bridges.remove_at(index)


func _on_growth_timer_timeout():
	power += 1
	growth_timer.start(growth_speed)


func _on_attack_timer_timeout():
	for bridge in bridges.get_children():
		if bridge:
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
