extends Node2D

var time_left=35
var correct_ans=-1
var user_ans=-1
onready var promt_tween=$proceed_tween

func _ready():
	_show_amt()
	correct_ans=global_script.json_ques.ans[global_script.ques_no-1]
	

func _on_timer_timeout():
	
	randomize()
	get_node("ques_amt/spark").show()
	get_node("ques_amt/spark2").show()
	var x = rand_range(0,220)
	var y = rand_range(20,44)
	var x1 = rand_range(0,220)
	var y1 = rand_range(20,42)
	get_node("ques_amt/spark").position=Vector2(x,y)
	get_node("ques_amt/spark2").position=Vector2(x1,y1)
	if(time_left>=0):
		time_left-=1
		get_node("timer_text").text=str(time_left)
	if(time_left<=0):
		$op1.disabled=true
		$op2.disabled=true
		$op3.disabled=true
		$op4.disabled=true
		get_node("../lifelines/aud_pole").disabled=true
		get_node("../lifelines/exp_adv").disabled=true
		get_node("../lifelines/x2").disabled=true
		get_node("timer").queue_free()
		$wrong_ans.play()
		get_node("prompt_c_w/msg").text="Oh No ! TIME'S UP"
		promt_tween.interpolate_property($prompt_c_w,"position",$prompt_c_w.position,Vector2(523,50),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()



func _on_op1_pressed():
	user_ans=0
	$op1.disabled=true
	$op2.disabled=true
	$op3.disabled=true
	$op4.disabled=true
	get_node("../lifelines/aud_pole").disabled=true
	get_node("../lifelines/exp_adv").disabled=true
	get_node("../lifelines/x2").disabled=true
	_prompt_and_check()


func _on_op2_pressed():
	user_ans=1
	$op1.disabled=true
	$op2.disabled=true
	$op3.disabled=true
	$op4.disabled=true
	get_node("../lifelines/aud_pole").disabled=true
	get_node("../lifelines/exp_adv").disabled=true
	get_node("../lifelines/x2").disabled=true
	_prompt_and_check()


func _on_op3_pressed():
	user_ans=2
	$op1.disabled=true
	$op2.disabled=true
	$op3.disabled=true
	$op4.disabled=true
	get_node("../lifelines/aud_pole").disabled=true
	get_node("../lifelines/exp_adv").disabled=true
	get_node("../lifelines/x2").disabled=true
	_prompt_and_check()


func _on_op4_pressed():
	user_ans=3
	$op1.disabled=true
	$op2.disabled=true
	$op3.disabled=true
	$op4.disabled=true
	get_node("../lifelines/aud_pole").disabled=true
	get_node("../lifelines/exp_adv").disabled=true
	get_node("../lifelines/x2").disabled=true
	_prompt_and_check()

func _prompt_and_check():
	promt_tween.interpolate_property($proceed,"position",$proceed.position,Vector2(0,-400),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
	promt_tween.start()

func _on_yes_pressed():
	if(user_ans==correct_ans):
		global_script.total_money_won=global_script.money[global_script.ques_no-1]
		$correct_ans.play()
		get_node("prompt_c_w/msg").text="Congrats ! You won RS. "+str(global_script.money[global_script.ques_no-1])
		promt_tween.interpolate_property($proceed,"position",$proceed.position,Vector2(0,100),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()
		promt_tween.interpolate_property($prompt_c_w,"position",$prompt_c_w.position,Vector2(523,50),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()
	else:
		$timer.queue_free()
		$wrong_ans.play()
		var ca="A"
		if correct_ans==1:
			ca="B"
		if correct_ans==2:
			ca="C"
		if correct_ans==3:
			ca="D"
		get_node("prompt_c_w/msg").text="Sorry ! Wrong Answer\nThe correct answer is "+ca
		promt_tween.interpolate_property($proceed,"position",$proceed.position,Vector2(0,100),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()	
		promt_tween.interpolate_property($prompt_c_w,"position",$prompt_c_w.position,Vector2(523,50),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()

func _on_no_pressed():
	$op1.disabled=false
	$op2.disabled=false
	$op3.disabled=false
	$op4.disabled=false
	get_node("../lifelines/aud_pole").disabled=false
	get_node("../lifelines/exp_adv").disabled=false
	get_node("../lifelines/x2").disabled=false
	promt_tween.interpolate_property($proceed,"position",$proceed.position,Vector2(0,100),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
	promt_tween.start()


func _on_proceed_pressed():
	if(user_ans==correct_ans):
		if(global_script.ques_no==11):
			get_tree().change_scene("res://assets/scns/cheque_intro.tscn")
		else:		
			promt_tween.interpolate_property($prompt_c_w,"position",$prompt_c_w.position,Vector2(523,782),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
			promt_tween.start()
			get_tree().reload_current_scene()
	else:
		promt_tween.interpolate_property($prompt_c_w,"position",$prompt_c_w.position,Vector2(523,782),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()
		get_tree().change_scene("res://assets/scns/cheque_intro.tscn")


func _show_amt():
	$ques_amt.text="Rs. "+str(global_script.money[global_script.ques_no-1])
	if(global_script.money[global_script.ques_no-1]<=100000):
		promt_tween.interpolate_property($ques_amt,"rect_position",$ques_amt.rect_position,Vector2(760,-115),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()
	else:
		promt_tween.interpolate_property($ques_amt,"rect_position",$ques_amt.rect_position,Vector2(710,-115),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
		promt_tween.start()
	
	
