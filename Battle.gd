extends Node

const BattleUnits = preload("res://Resources/BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var player_actions: GridContainer = $UI/ActionButtons/
onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var next_room: Button = $UI/CenterContainer/NextRoomButton
onready var enemy_pos: Position2D = $EnemyPostion

func _ready():
	start_player_turn()
	var enemy = BattleUnits.enemy
	if enemy:
		enemy.connect("enemy_death", self, "_on_Enemy_died")
	
# Player's turn, allow player actions and replenish ap
func start_player_turn():
	var player = BattleUnits.player_stats
	if player:
		player_actions.show()
		player.ap = 3
		yield(player, "end_turn")
		start_enemy_turn()

# Enemy will attack on its turn
func start_enemy_turn():
	player_actions.hide()
	var enemy: Node = BattleUnits.enemy
	if enemy and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(enemy, "end_turn")
		start_player_turn()

func create_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	enemy_pos.add_child(enemy)
	enemy.connect("enemy_death", self, "_on_Enemy_died")

func _on_Enemy_died():
	next_room.show()
	player_actions.hide()

func _on_NextRoomButton_pressed():
	next_room.hide()
	anim_player.play("FadeToNewRoom")
	yield(anim_player, "animation_finished")
	BattleUnits.player_stats.ap = BattleUnits.player_stats.max_ap
	player_actions.show()
	create_enemy()
