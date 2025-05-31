class_name Hole
extends StaticBody2D

func _player_entered(body: Node2D) -> void:
	if (body.in_dash):
		body.fall_in_hole()
