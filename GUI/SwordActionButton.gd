extends "res://GUI/ActionButton.gd"

const Slash = preload("res://Effects/SlashEffect.tscn")

func _on_pressed():
	var player_stats: Node = BattleUnits.player_stats
	var enemy: Node = BattleUnits.enemy
	
	if enemy:
		create_slash(enemy.global_position)
		enemy.take_damage(4)
		player_stats.ap -= 1
		player_stats.mp += 2

func create_slash(position):
	var slash: Node = Slash.instance()
	var main: Node = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
