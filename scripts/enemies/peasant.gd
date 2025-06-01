class_name Peasant
extends Enemy

func _ready() -> void:
	$Sprite2D.modulate = Color.AQUA
	health = 3
	movement_speed = 200
	cause_rush_chance = 20
	enemy_type = 0
	$Sprite.play("walk")
	super()

func _process(delta: float) -> void:
	super(delta)
	if (target and $AttackCooldownTimer.is_stopped() and not goldified):
		$Sprite.flip_h = global_position < target.global_position

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	movement_speed = 0
	$AttackCooldownTimer.start()
	$Hitbox.set_collision_mask_value(3, false)
	$Sprite.play("attack")
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
	movement_speed = 250
	$Sprite.play("walk")
	$Hitbox.set_collision_mask_value(3, true)
