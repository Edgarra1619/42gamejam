class_name Miner
extends Enemy

var in_rage: bool = false

func _ready() -> void:
	movement_speed = 100
	health = 9
	cause_rush_chance = 50
	enemy_type = 1
	$Sprite.play("walk")
	super()

func _process(delta: float) -> void:
	super(delta)
	if (health <= 3 and not in_rage):
		rage_mode()
	if (target and $AttackCooldownTimer.is_stopped() and $Hitbox.get_collision_mask_value(3)):
		$Sprite.flip_h = global_position < target.global_position

func _on_hitbox_body_entered(body: Node2D) -> void:
	if (body is not Player):
		return
	movement_speed = 0
	$AttackCooldownTimer.start()
	$Hitbox.set_collision_mask_value(3, false)
	$Sprite.play("destroy")
	var potion_type = body.lose_potion()
	if (potion_type == -1):
		return
	(func ():
		var potion = preload("res://scenes/dropped_potion.tscn").instantiate()
		get_tree().current_scene.add_child(potion)
		potion.set_potion_type(potion_type)
		potion.fly_away_from_player()
	).call_deferred()

func rage_mode() -> void:
	in_rage = true
	movement_speed = 200
	$HoleTimer.start()
	$Sprite.modulate = Color.RED

func dig_hole() -> void:
	movement_speed = 0
	$AttackCooldownTimer.start()
	$Hitbox.set_collision_mask_value(3, false)
	$Sprite.play("destroy")
	var hole = preload("res://scenes/hole.tscn").instantiate()
	hole.global_position = global_position
	get_tree().current_scene.add_child(hole)

func reengage_chase() ->void:
	if (in_rage):
		movement_speed = 200
	else:
		movement_speed = 100
	$Sprite.play("walk")
	$Hitbox.set_collision_mask_value(3, true)

func _die() -> void:
	Game.game.enemy_count[1] -= 1
	super()
