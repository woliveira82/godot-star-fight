extends Node2D


const RED_STAR = preload("res://assets/red.png")
const BLUE_STAR = preload("res://assets/blue.png")
const GRAY_STAR = preload("res://assets/gray.png")

@onready var sprite := $Sprite2D
@onready var timer := $Timer
@onready var power_label := $Power

var power: int = 0 : set = set_power
@export var player: bool = false


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
