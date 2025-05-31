class_name GreenPotion
extends Potion

static var acid_pool: PackedScene = preload("res://scenes/acid_pool.tscn")

static func new_potion(pos : Vector2) -> GreenPotion:
	potion = preload("res://scenes/potions/green_potion.tscn")
	var newpot : GreenPotion = potion.instantiate()
	newpot.target_position = pos
	newpot.impact_damage = 0
	return newpot

func _explode():
	if (!dest_clock.is_stopped()):
		return
	var new_acid_pool: AcidPool = acid_pool.instantiate()
	get_tree().current_scene.add_child(new_acid_pool)
	new_acid_pool.global_position = global_position
	super()
	pass
