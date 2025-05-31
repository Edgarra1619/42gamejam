class_name Peasant
extends Enemy

func _ready() -> void:
	$Sprite2D.modulate = Color.AQUA
	health = 3
	movement_speed = 400
	cause_rush_chance = 20
	super()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		#Player.player.lose_potion() <- TODO
		movement_speed = 0
		$AttackCooldownTimer.start()

func reengage_chase() ->void:
	movement_speed = 400
