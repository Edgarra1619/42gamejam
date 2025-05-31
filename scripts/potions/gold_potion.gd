class_name GoldPotion
extends Potion

static func new_potion(pos : Vector2) -> GoldPotion:
	var newpot : GoldPotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 0
	return newpot

func _explode():
	super()
	pass
