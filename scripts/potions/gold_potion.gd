class_name GoldPotion
extends Potion

static func new_potion(pos : Vector2) -> GoldPotion:
	potion = preload("res://scenes/potions/gold_potion.tscn")
	var newpot : GoldPotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 0
	newpot.modulate = Color.GOLD
	return newpot

func _explode():
	super()
	pass

func _goldify_enemy(body: Node2D) -> void:
	if (!dest_clock.is_stopped()):
		return
	if (body is Enemy):
		body.turn_gold()
