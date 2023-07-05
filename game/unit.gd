extends PathFollow2D

@onready var sprite := $Sprite2D


func _physics_process(_delta):
	progress += 1.0


func set_unit(team: GameData.TEAM):
	sprite.texture = GameData.get_team(team).texture
