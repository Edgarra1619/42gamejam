class_name GoldPotion
extends Potion

static func new_potion(pos : Vector2) -> Potion:
	var newpot : Potion = potion.instantiate()
	newpot.target_position = pos
	return newpot

func _explode():
	super()
	pass