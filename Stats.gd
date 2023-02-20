extends Panel

onready var hp_label: Label = $StatGrid/HP
onready var ap_label: Label = $StatGrid/AP
onready var mp_label: Label = $StatGrid/MP

func _on_PlayerStats_hp_changed(new_hp):
	hp_label.text = "HP\n" + str(new_hp)

func _on_PlayerStats_ap_changed(new_ap):
	ap_label.text = "AP\n" + str(new_ap)

func _on_PlayerStats_mp_changed(new_mp):
	mp_label.text = "MP\n" + str(new_mp)
