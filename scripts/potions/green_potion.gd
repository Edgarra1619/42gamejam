class_name GreenPotion
extends Potion

static func new_potion(pos : Vector2) -> GreenPotion:
	var newpot : GreenPotion = potion.instantiate()
	newpot.target_position = pos
	return newpot

func _explode():
	super()
	pass