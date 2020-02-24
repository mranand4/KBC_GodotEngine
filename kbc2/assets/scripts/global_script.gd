extends Node

var ques_no = 0
var ques_no_temp=0
var json_ques
var lifeline_aud_pole=0
var lifeline_exp_adv=0
var lifeline_x2=0
var money = [10000,20000,40000,80000,160000,320000,640000,1250000,2500000,5000000,10000000]
var total_money_won=0
var player_name="Lallu Lal"
var rew_ads_count=0

func _set_initial_ques_number():
	ques_no =0
	
func _get_questions(var json_obj):
	json_ques = json_obj.result
	print(json_ques)
	
func _set_initial():
	lifeline_aud_pole=0
	lifeline_exp_adv=0
	lifeline_x2=0
