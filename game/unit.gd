extends PathFollow2D

@onready var sprite := $Sprite2D
@onready var area := $UnitArea

var force: int = 0


func _physics_process(_delta):
	progress += 1.0
	if progress_ratio == 1.0:
		queue_free()


func set_unit(team: GameData.TEAM, origin_star: Node2D, attack_force := 1, unit_progress = 0):
	force = attack_force
	progress_ratio = unit_progress
	sprite.texture = GameData.get_team(team).texture
	area.team = team
	area.origin = origin_star
	area.force = attack_force
