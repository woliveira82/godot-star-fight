extends PathFollow2D

@onready var sprite := $Sprite2D
@onready var unit := $UnitArea

var force: int : set = set_force
var next_force: int = -1
var team: GameData.TEAM : set = set_team


func _physics_process(_delta):
	if next_force >= 0:
		force = next_force
		next_force = -1

	progress += 1.0
	if progress_ratio == 1.0:
		queue_free()


func set_force(new_force: int):
	force = new_force
	if force <= 0:
		queue_free()

	unit.force = new_force


func set_team(new_team: GameData.TEAM):
	team = new_team
	unit.team = new_team


func set_unit(unit_team: GameData.TEAM, origin_star: Node2D, attack_force := 1, unit_progress = 0):
	self.force = attack_force
	self.team = unit_team
	progress_ratio = unit_progress
	sprite.texture = GameData.get_team(team).texture
	unit.origin = origin_star


func _on_unit_area_area_entered(area):
	if area.team == team:
		return
	
	next_force = max(force - area.force, 0)
