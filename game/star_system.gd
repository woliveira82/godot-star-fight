extends Node2D


const RED_STAR = preload("res://assets/red.png")
const BLUE_STAR = preload("res://assets/blue.png")
const GRAY_STAR = preload("res://assets/gray.png")

@onready var sprite := $StarColor
@onready var selection := $StarSelection
@onready var timer := $Timer
@onready var power_label := $Power

@export var player: bool = false

var power: int = 0 : set = set_power
var bridges := []


func _ready():
	if player:
		sprite.texture = BLUE_STAR


func set_power(new_power):
	power = new_power
	if power_label:
		power_label.text = str(power)


func _on_timer_timeout():
	power += 1
	timer.start(1.0 if player else 2.0)


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
