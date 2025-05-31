class_name RedPotion
extends Potion
	
static func new_potion(pos : Vector2) -> Potion:
	var newpot : Potion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 3
	return newpot

func _explode():
	#insert red explosion logic
	super()
	pass
