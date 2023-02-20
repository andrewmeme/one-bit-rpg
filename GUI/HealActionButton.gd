extends "res://GUI/ActionButton.gd"

var heal_cost: int = 8
var heal_amount: int = 5

func _on_pressed():
	var main: Node = get_tree().current_scene
	var player_stats: Node = BattleUnits.player_stats
	if player_stats and player_stats.ap and player_stats.mp >= heal_cost:
		player_stats.mp -= heal_cost
		player_stats.hp += heal_amount
		player_stats.ap -= 1
