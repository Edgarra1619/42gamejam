class_name Game
extends Node

const MAX_ENEMIES = 100
const ENEMY_LIMITS = [MAX_ENEMIES, 4, 2]

static var enemies: Array = [
	preload("res://scenes/enemies/peasant.tscn"),
	preload("res://scenes/enemies/miner.tscn"),
	preload("res://scenes/enemies/banker.tscn")
]
static var game: Game = self
var doors: Array
var enemy_count: Array = [0, 0, 0]
var score: int = 0

func _ready() -> void:
	game = self
	doors = $Doors.get_children()

func can_spawn_enemy(enemy_type: int) -> bool:
	return (enemy_count[enemy_type] < ENEMY_LIMITS[enemy_type])

func get_enemy_count() -> int:
	return (enemy_count[0] + enemy_count[1] + enemy_count[2])

func spawn_enemy() -> void:
	if (get_enemy_count() >= MAX_ENEMIES):
		return
	var i = randi() % enemies.size()
	while (not can_spawn_enemy(i)):
		i = randi() % enemies.size()
	enemy_count[i] += 1
	var enemy = enemies[i].instantiate()
	var door = doors[randi() % doors.size()]
	enemy.global_position = door.global_position
	if (i == 2):
		enemy.escape_routes = doors
	get_tree().current_scene.add_child(enemy)

func _on_game_over() -> void:
	$ScoreTimer.stop()

func increase_score() -> void:
	score += 100
