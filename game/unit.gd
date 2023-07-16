extends Area2D

@onready var sprite := $Sprite2D

var force: int : set = set_force
var team: GameData.TEAM : set = set_team
var origin: Node2D
var destiny: Node2D


func _physics_process(_delta):
	var final_position = destiny.position - origin.position
	position = position.move_toward(final_position, 1.0)
	if position == final_position:
		queue_free()


func set_force(new_force: int):
	force = new_force
	if force <= 0:
		queue_free()


func set_team(new_team: GameData.TEAM):
	team = new_team


func set_unit(
	unit_team: GameData.TEAM,
	origin_star: Node2D,
	destiny_star: Node2D,
	attack_force := 1,
	new_position := Vector2.ZERO
):
	self.force = attack_force
	self.team = unit_team
	position = new_position
	sprite.texture = GameData.get_team(team).texture
	origin = origin_star
	destiny = destiny_star
	var direction = destiny.position - origin.position
	rotate(direction.angle())


func _on_area_entered(area):
	if area.team == team:
		return
	
	set_deferred("force", force - area.force)
