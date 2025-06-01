class_name Peasant
extends Enemy

func _ready() -> void:
	$Sprite2D.modulate = Color.AQUA
	health = 3
	movement_speed = 400
	cause_rush_chance = 20
	super()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	movement_speed = 0
	$AttackCooldownTimer.start()
	var potion_type = body.lose_potion()
	if (potion_type == -1):
		return
	(func ():
		var potion = preload("res://scenes/dropped_potion.tscn").instantiate()
		get_tree().current_scene.add_child(potion)
		potion.set_potion_type(potion_type)
		potion.fly_away_from_player()
	).call_deferred()

func reengage_chase() ->void:
	movement_speed = 400
