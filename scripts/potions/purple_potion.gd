class_name Purple_Potion
extends Potion

static func new_potion(pos : Vector2) -> Potion:
	var newpot : Purple_Potion = potion.instantiate()
	newpot.target_position = pos
	return newpot

func _explode():
	super()
	pass