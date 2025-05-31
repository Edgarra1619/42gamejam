class_name Game
extends Node

static var enemies: Array = [
	preload("res://scenes/enemies/peasant.tscn"),
	preload("res://scenes/enemies/miner.tscn"),
	preload("res://scenes/enemies/banker.tscn")
]
static var game : Game = self
var doors: Array

func _ready() -> void:
	doors = $Doors.get_children()

func spawn_enemy() -> void:
	var i = randi() % enemies.size()
	var enemy = enemies[i].instantiate()
	var door = doors[randi() % doors.size()]
	enemy.global_position = door.global_position
	if (i == 2):
		enemy.escape_routes = doors
	get_tree().current_scene.add_child(enemy)
