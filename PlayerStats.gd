extends Node

const BattleUnits = preload("res://Resources/BattleUnits.tres")

var max_hp: int = 25
var hp: int = max_hp setget set_hp
var max_ap: int = 3
var ap: int = max_ap setget set_ap
var max_mp: int = 10
var mp: int = max_mp setget set_mp

signal hp_changed(new_hp)
signal ap_changed(new_ap)
signal mp_changed(new_mp)
signal end_turn

func set_hp(new_hp):
	hp = clamp(new_hp, 0, max_hp)
	emit_signal("hp_changed", hp)

func set_ap(new_ap):
	ap = clamp(new_ap, 0, max_ap)
	emit_signal("ap_changed", ap)
	if ap == 0:
		emit_signal("end_turn")

func set_mp(new_mp):
	mp = clamp(new_mp, 0, max_mp)
	emit_signal("mp_changed", mp)
	
func _ready():
	BattleUnits.player_stats = self
	
func _exit_tree():
	BattleUnits.player_stats = null
