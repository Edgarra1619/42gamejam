class_name Miner
extends Enemy

var in_rage: bool = false

func _ready() -> void:
	$Sprite2D.modulate = Color.RED
	movement_speed = 350 # slower enemy at first
	health = 9
	cause_rush_chance = 50
	enemy_type = 1
	super()

func _process(delta: float) -> void:
	super(delta)
	if (health <= 3 and not in_rage):
		rage_mode()

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

func rage_mode() -> void:
	in_rage = true
	movement_speed = 750
	$HoleTimer.start()
	$Sprite2D.modulate = Color.RED

func dig_hole() -> void:
	var hole = preload("res://scenes/hole.tscn").instantiate()
	hole.global_position = global_position
	get_tree().current_scene.add_child(hole)

func reengage_chase() ->void:
	if (in_rage):
		movement_speed = 750
	else:
		movement_speed = 350

func _die() -> void:
	Game.game.enemy_count[1] -= 1
	super()
