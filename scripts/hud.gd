class_name Hud
extends Control

@export var player: Player

func _on_player_switched_potion() -> void:
	$CurrentPotion.text = str("Current Potion: ", player.current_potion)

func _on_player_threw_potion() -> void:
	pass
