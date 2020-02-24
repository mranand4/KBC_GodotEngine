extends Node2D

func _ready():
	VisualServer.set_default_clear_color(Color(0,0,0))


func _on_Button_pressed():
	if(len($LineEdit.text)>0):
		global_script.player_name=$LineEdit.text
		get_tree().change_scene("res://assets/scns/cheque.tscn")
	else:
		get_tree().change_scene("res://assets/scns/menu.tscn")


func _on_Button2_button_down():
	get_tree().change_scene("res://assets/scns/menu.tscn")
