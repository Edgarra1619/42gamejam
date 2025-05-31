class_name AcidPool
extends Area2D

func _duration_over() -> void:
	queue_free()

func _deal_damage() -> void:
	var enemies = get_overlapping_bodies()
	for i in enemies.size():
		enemies[i].receive_damage(1)
		enemies[i].get_slowed()
