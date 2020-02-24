extends Node2D

onready var qnot = get_node("qnot")
var secs=4;
func _ready():
	$ques_theme.play()
	get_node("qno").text=get_node("qno").text+" "+str(global_script.ques_no)
	qnot.interpolate_property(get_node("qno"),"rect_position",get_node("qno").rect_position,Vector2(13,get_node("qno").rect_position.y),0.4,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	qnot.start()


func _on_take_n_quit_pressed():
	get_tree().change_scene("res://assets/scns/cheque_intro.tscn")


func _on_ques_theme_finish_timeout():
	if(secs>=0):
		secs=secs-1
	if(secs<0):
		$ques_theme.stop()
		$ques_theme.queue_free()
		$ques_theme_finish.queue_free()
