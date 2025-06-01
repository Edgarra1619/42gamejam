class_name GreenPotion
extends Potion

static var acid_pool: PackedScene = preload("res://scenes/acid_pool.tscn")

static func new_potion(pos : Vector2) -> GreenPotion:
	potion = preload("res://scenes/potions/green_potion.tscn")
	var newpot : GreenPotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 0
	newpot.modulate = Color.GREEN
	return newpot

func _explode():
	if (!dest_clock.is_stopped()):
		return
	(func (pos : Vector2):
		var new_acid_pool: AcidPool = acid_pool.instantiate()
		new_acid_pool.global_position = pos
		get_tree().current_scene.add_child(new_acid_pool)
	).call_deferred(global_position)
	super()
	pass
