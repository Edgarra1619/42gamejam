class_name DroppedPotion
extends Area2D

const FLY_SPEED = 100

var potion_type: int = 0
var fly_direction: float = 0

func _physics_process(delta: float) -> void:
	if (get_collision_mask_value(3)):
		return
	global_position = global_position.move_toward(global_position + Vector2.from_angle(fly_direction) * FLY_SPEED, delta * FLY_SPEED)

func set_potion_type(i: int):
	potion_type = i
	match i:
		0:
			$Sprite2D.modulate = Color.RED
		1:
			$Sprite2D.modulate = Color.PURPLE
		2:
			$Sprite2D.modulate = Color.GREEN
		3:
			$Sprite2D.modulate = Color.GOLD

func fly_away_from_player() -> void:
	if (not Player.player):
		pass
	$PlaceTimer.start()
	set_collision_mask_value(3, false)
	global_position = Player.player.global_position
	fly_direction = randf_range(0, TAU)

func place() -> void:
	set_collision_mask_value(3, true)

func _player_entered(body: Node2D) -> void:
	if (body is not Player):
		return
	body.pick_up_potion(potion_type)
	queue_free()
