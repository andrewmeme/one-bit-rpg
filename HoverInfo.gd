extends Control

export(String, MULTILINE) var desc = ""

func _on_HoverInfo_mouse_entered():
	var main = get_tree().current_scene
	var textbox = main.find_node("Textbox")
	if textbox:
		textbox.text = desc

func _on_HoverInfo_mouse_exited():
	pass # Replace with function body.
