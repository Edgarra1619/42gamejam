class_name Hole
extends StaticBody2D

func _player_entered(body: Node2D) -> void:
	body.fall_in_hole()
