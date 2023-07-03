extends Node2D

@onready var timer := $Timer
@onready var power_label := $Power

var power: int = 0 : set = set_power
var player: bool = false


func set_power(new_power):
	power = new_power
	if power_label:
		power_label.text = str(power)


func _on_timer_timeout():
	power += 1
	timer.start(1.0 if player else 2.0)
