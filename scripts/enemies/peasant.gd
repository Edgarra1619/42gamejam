class_name Peasant
extends Enemy

func _ready() -> void:
	$Sprite2D.modulate = Color.AQUA
	health = 3
	movement_speed = 400
	super()

func _on_hitbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		#Player.player.lose_potion() <- TODO
		movement_speed = 0
		$AttackCooldownTimer.start()

func reengage_chase() ->void:
	movement_speed = 400
