class_name DroppedPotion
extends Area2D

var potion_type: int

func set_potion_type(i: int):
	potion_type = i
	match i:
		0:
			$Sprite2D.modulate = Color.RED
		1:
			$Sprite2D.modulate = Color.PURPLE
		2:
			$Sprite2D.modulate = Color.GREEN
		3:
			$Sprite2D.modulate = Color.GOLD

func _player_entered(body: Node2D) -> void:
	body.pick_up_potion(potion_type)
	queue_free()
