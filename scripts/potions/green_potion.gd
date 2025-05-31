class_name GreenPotion
extends Potion

static func new_potion(pos : Vector2) -> GreenPotion:
	var newpot : GreenPotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 0
	return newpot

func _explode():
	super()
	pass
