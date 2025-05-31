class_name PurplePotion
extends Potion

static func new_potion(pos: Vector2) -> PurplePotion:
	potion = preload("res://scenes/potions/purple_potion.tscn")
	var newpot : PurplePotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 0
	return newpot

func _explode():
	if (not has_exploded):
		var enemies = $PoisonDamageArea.get_overlapping_bodies()
		for i in enemies.size():
			enemies[i].get_poisoned()
	super()
	pass
