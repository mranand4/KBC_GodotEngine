extends Node2D

var ques_text
var ques_text_in=0

var op1_text
var op1_text_in=0

var op2_text
var op2_text_in=0

var op3_text
var op3_text_in=0

var op4_text
var op4_text_in=0

func _ready():
	get_node("../op1").disabled=true
	get_node("../op2").disabled=true
	get_node("../op3").disabled=true
	get_node("../op4").disabled=true
	global_script.ques_no+=1
	if(global_script.ques_no<=11):
		ques_text=global_script.json_ques.ques[global_script.ques_no-1]
		op1_text=global_script.json_ques.op[global_script.ques_no-1][0]
		op2_text=global_script.json_ques.op[global_script.ques_no-1][1]
		op3_text=global_script.json_ques.op[global_script.ques_no-1][2]
		op4_text=global_script.json_ques.op[global_script.ques_no-1][3]
		op1_text=op1_text+" "
		op2_text=op2_text+" "
		op3_text=op3_text+" "
		op4_text=op4_text+" "
	
	
	get_node("draw_timer").start()



func _on_draw_timer_timeout():
	_draw_ques()

func _draw_ques():
	if(ques_text_in<len(ques_text)):
		$question.text=$question.text+ques_text[ques_text_in]
		ques_text_in+=1
	if(ques_text_in>=len(ques_text)):
		get_node("draw_timer").wait_time=0.06
		if(op1_text_in<len(op1_text)):
			$op1.text=$op1.text+op1_text[op1_text_in]
			op1_text_in+=1
		if(op1_text_in>=(len(op1_text)) and op2_text_in<len(op2_text)):
			$op2.text=$op2.text+op2_text[op2_text_in]
			op2_text_in+=1
		if(op2_text_in>=(len(op2_text)) and op3_text_in<len(op3_text)):
			$op3.text=$op3.text+op3_text[op3_text_in]
			op3_text_in+=1
		if(op3_text_in>=(len(op3_text)) and op4_text_in<len(op4_text)):
			$op4.text=$op4.text+op4_text[op4_text_in]
			op4_text_in+=1
		if(op4_text_in>=len(op4_text)):
			get_node("../op1").disabled=false
			get_node("../op2").disabled=false
			get_node("../op3").disabled=false
			get_node("../op4").disabled=false
			get_node("../timer").start()
			get_node("draw_timer").queue_free()
