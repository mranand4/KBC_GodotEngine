extends Node2D

onready var t_aud=get_node("tween_aud")
onready var t_exp=get_node("tween_exp")
onready var t_x2=get_node("tween_x2")
onready var t_aud_main=get_node("tween_aud_main")
var aud_pole_used_texture = load("res://assets/sprites/lifelines_aud_used.png")
var exp_adv_used_texture = load("res://assets/sprites/lifelines_expert_used.png")
var x2_used_texture=load("res://assets/sprites/lifelines_x2_used.png")
var correct_ans

func _ready():
	correct_ans=global_script.json_ques.ans[global_script.ques_no-1]
	_set_textures()
	_tween_aud()

func _tween_aud():
	t_aud.interpolate_property(get_node("aud_pole"),"rect_position",get_node("aud_pole").rect_position,Vector2(250,get_node("aud_pole").rect_position.y),0.8,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	t_aud.start()
	
func _tween_exp():
	t_exp.interpolate_property(get_node("exp_adv"),"rect_position",get_node("exp_adv").rect_position,Vector2(130,get_node("exp_adv").rect_position.y),0.6,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	t_exp.start()
	
func _tween_x2():
	t_x2.interpolate_property(get_node("x2"),"rect_position",get_node("x2").rect_position,Vector2(10,get_node("x2").rect_position.y),0.4,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	t_x2.start()

func _on_tween_aud_tween_completed(object, key):
	_tween_exp()


func _on_tween_exp_tween_completed(object, key):
	_tween_x2()
	
func _on_aud_pole_pressed():
	if(global_script.lifeline_aud_pole==0):
		$aud_pole.disabled=true
		$exp_adv.disabled=true
		$x2.disabled=true
		get_node("../ques_and_op/op1").disabled=true
		get_node("../ques_and_op/op2").disabled=true
		get_node("../ques_and_op/op3").disabled=true
		get_node("../ques_and_op/op4").disabled=true
		t_aud_main.interpolate_property(get_node("aud_pole_main"),"position",$aud_pole_main.position,Vector2($aud_pole_main.position.x,100),0.8,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		t_aud_main.start()
		_aud_pole()
		global_script.lifeline_aud_pole=1
	

func _on_exp_adv_pressed():
	if(global_script.lifeline_exp_adv==0):
		$aud_pole.disabled=true
		$exp_adv.disabled=true
		$x2.disabled=true
		get_node("../ques_and_op/op1").disabled=true
		get_node("../ques_and_op/op2").disabled=true
		get_node("../ques_and_op/op3").disabled=true
		get_node("../ques_and_op/op4").disabled=true
		t_aud_main.interpolate_property(get_node("exp_adv_main"),"position",$exp_adv_main.position,Vector2($exp_adv_main.position.x,100),0.8,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		t_aud_main.start()
		_exp_adv_main()
		global_script.lifeline_exp_adv=1

func _on_aud_bacl_pressed():
	$aud_pole.disabled=false
	$exp_adv.disabled=false
	$x2.disabled=false
	get_node("../ques_and_op/op1").disabled=false
	get_node("../ques_and_op/op2").disabled=false
	get_node("../ques_and_op/op3").disabled=false
	get_node("../ques_and_op/op4").disabled=false
	t_aud_main.interpolate_property(get_node("aud_pole_main"),"position",$aud_pole_main.position,Vector2(479,-400),0.8,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	t_aud_main.start()
	$aud_pole.texture_normal=aud_pole_used_texture

func _on_exp_adv_main_back_pressed():
	$aud_pole.disabled=false
	$exp_adv.disabled=false
	$x2.disabled=false
	get_node("../ques_and_op/op1").disabled=false
	get_node("../ques_and_op/op2").disabled=false
	get_node("../ques_and_op/op3").disabled=false
	get_node("../ques_and_op/op4").disabled=false
	t_aud_main.interpolate_property(get_node("exp_adv_main"),"position",$exp_adv_main.position,Vector2($exp_adv_main.position.x,-453),0.8,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	t_aud_main.start()
	$exp_adv.texture_normal=exp_adv_used_texture
	
func _on_x2_pressed():
	if(global_script.lifeline_x2==0):
		_x2_main()
		global_script.lifeline_x2=1
		$x2.texture_normal=x2_used_texture
	
func _set_textures():
	if(global_script.lifeline_aud_pole==1):
		$aud_pole.texture_normal=aud_pole_used_texture
	if(global_script.lifeline_exp_adv==1):
		$exp_adv.texture_normal=exp_adv_used_texture
	if(global_script.lifeline_x2==1):
		$x2.texture_normal=x2_used_texture
		
func _aud_pole():
	if(global_script.lifeline_aud_pole==0):
		var ca
		var correct_ans_bar=int(rand_range(70,100))
		var wrong_ans_1=int(rand_range(50,70))
		var wrong_ans_2=int(rand_range(30,50))
		var wrong_ans_3=int(rand_range(5,30))
		if(correct_ans==0):
			ca="op_a"
			get_node("aud_pole_main/"+ca).scale.y=correct_ans_bar
			get_node("aud_pole_main/op_b").scale.y=wrong_ans_1
			get_node("aud_pole_main/op_c").scale.y=wrong_ans_2
			get_node("aud_pole_main/op_d").scale.y=wrong_ans_3
		if(correct_ans==1):
			ca="op_b"
			get_node("aud_pole_main/"+ca).scale.y=correct_ans_bar
			get_node("aud_pole_main/op_c").scale.y=wrong_ans_1
			get_node("aud_pole_main/op_d").scale.y=wrong_ans_2
			get_node("aud_pole_main/op_a").scale.y=wrong_ans_3
		if(correct_ans==2):
			ca="op_c"
			get_node("aud_pole_main/"+ca).scale.y=correct_ans_bar
			get_node("aud_pole_main/op_a").scale.y=wrong_ans_1
			get_node("aud_pole_main/op_b").scale.y=wrong_ans_2
			get_node("aud_pole_main/op_d").scale.y=wrong_ans_3
		if(correct_ans==3):
			ca="op_d"
			get_node("aud_pole_main/"+ca).scale.y=correct_ans_bar
			get_node("aud_pole_main/op_c").scale.y=wrong_ans_1
			get_node("aud_pole_main/op_b").scale.y=wrong_ans_2
			get_node("aud_pole_main/op_a").scale.y=wrong_ans_3

func _exp_adv_main():
	var ans
	if(correct_ans==0):
		ans="A"
	if(correct_ans==1):
		ans="B"
	if(correct_ans==2):
		ans="C"
	if(correct_ans==3):
		ans="D"
	
	$exp_adv_main/exp_adv_txt.text=$exp_adv_main/exp_adv_txt.text+" "+ans


func _x2_main():
	get_node("../ques_and_op/op1").hide()
	get_node("../ques_and_op/op2").hide()
	get_node("../ques_and_op/op3").hide()
	get_node("../ques_and_op/op4").hide()
	get_node("../ques_and_op/a_not").hide()
	get_node("../ques_and_op/b_not").hide()
	get_node("../ques_and_op/c_not").hide()
	get_node("../ques_and_op/d_not").hide()
	get_node("../ques_and_op/text_label/op1").hide()
	get_node("../ques_and_op/text_label/op2").hide()
	get_node("../ques_and_op/text_label/op3").hide()
	get_node("../ques_and_op/text_label/op4").hide()	
	
	
	
	var second_ans
	if(correct_ans==0):
		get_node("../ques_and_op/a_not").show()
		get_node("../ques_and_op/op1").show()
		get_node("../ques_and_op/text_label/op1").show()
		second_ans=int(rand_range(1,4))
	if(correct_ans==1):
		get_node("../ques_and_op/b_not").show()
		get_node("../ques_and_op/op2").show()
		get_node("../ques_and_op/text_label/op2").show()
		second_ans=int(rand_range(2,4))
	if(correct_ans==2):
		get_node("../ques_and_op/c_not").show()
		get_node("../ques_and_op/op3").show()
		get_node("../ques_and_op/text_label/op3").show()
		second_ans=int(rand_range(0,2))
	if(correct_ans==3):
		get_node("../ques_and_op/d_not").show()
		get_node("../ques_and_op/op4").show()
		get_node("../ques_and_op/text_label/op4").show()
		second_ans=int(rand_range(0,3))
	if(second_ans==0):
		get_node("../ques_and_op/a_not").show()
		get_node("../ques_and_op/op1").show()
		get_node("../ques_and_op/text_label/op1").show()
	if(second_ans==1):
		get_node("../ques_and_op/b_not").show()
		get_node("../ques_and_op/text_label/op2").show()
		get_node("../ques_and_op/op2").show()
	if(second_ans==2):
		get_node("../ques_and_op/c_not").show()
		get_node("../ques_and_op/text_label/op3").show()
		get_node("../ques_and_op/op3").show()
	if(second_ans==3):
		get_node("../ques_and_op/d_not").show()
		get_node("../ques_and_op/text_label/op4").show()
		get_node("../ques_and_op/op4").show()
	
	
