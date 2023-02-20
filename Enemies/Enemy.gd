extends Node2D

const BattleUnits = preload("res://Resources/BattleUnits.tres")

export(int) var hp: int = 25 setget set_hp
export(int) var dmg: int = 3

onready var hp_label: Label = $HPLabel
onready var anim_player: AnimationPlayer = $AnimationPlayer

signal end_turn
signal enemy_death

func set_hp(new_hp):
	hp = new_hp
	if hp_label:
		hp_label.text = str(hp) + " hp"
	
	if hp <= 0:
		queue_free()
		emit_signal("enemy_death")
	
func _ready():
	BattleUnits.enemy = self

func _exit_tree():
	BattleUnits.enemy = null

func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	anim_player.play("Attack")
	yield(anim_player, "animation_finished")
	emit_signal("end_turn")

func is_dead() -> bool:
	return hp <= 0

func deal_damage() -> void:
	if BattleUnits.player_stats:
		BattleUnits.player_stats.hp -= dmg

func take_damage(amount: int):
	self.hp -= amount
	if is_dead():
		queue_free()
	else:
		anim_player.play("Shake")
		yield(anim_player, "animation_finished")
		
	
