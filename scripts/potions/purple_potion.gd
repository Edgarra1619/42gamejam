class_name PurplePotion
extends Potion

static func new_potion(pos: Vector2) -> PurplePotion:
	potion = preload("res://scenes/potions/purple_potion.tscn")
	var newpot : PurplePotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 0
	newpot.modulate = Color.PURPLE
	return newpot

func _explode():
	if (!dest_clock.is_stopped()):
		return
	var enemies = $PoisonDamageArea.get_overlapping_bodies()
	for i in enemies.size():
		enemies[i].get_poisoned()
	super()
	pass
