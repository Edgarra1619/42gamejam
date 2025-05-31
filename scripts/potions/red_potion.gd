class_name RedPotion
extends Potion
	
static func new_potion(pos: Vector2) -> RedPotion:
	potion = preload("res://scenes/potions/red_potion.tscn")
	var newpot : RedPotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 3
	return newpot

func _explode():
	super()
	pass
