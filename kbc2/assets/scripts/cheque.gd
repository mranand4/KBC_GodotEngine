extends Node2D

var money_disp

func _ready():
		
	var dt = OS.get_datetime()
	var date = dt["day"]
	var month = dt["month"]
	var year = dt["year"]
	get_node("date2").bbcode_text="[u]"+str(date)+"/"+str(month)+"/"+str(year)+"[/u]"
	
	
	VisualServer.set_default_clear_color(Color(0.22,0.08,0.29))
	$rec_name.bbcode_text="[u]"+global_script.player_name+"[/u]"
	var mony = global_script.total_money_won
	if(mony==0):
		money_disp="Lallu"
	if(mony==10000):
		money_disp="Ten Thousand"
	if(mony==20000):
		money_disp="Twenty Thousand"
	if(mony==40000):
		money_disp="Forty Thousand"
	if(mony==80000):
		money_disp="Eighty Thousand"
	if(mony==160000):
		money_disp="One Lakh Sixty Thousand"
	if(mony==320000):
		money_disp="Three Lakh Twenty Thousand"
	if(mony==640000):
		money_disp="Six Lakh Forty Thousand"
	if(mony==1250000):
		money_disp="Twelve Lakh Fifty Thousand"
	if(mony==2500000):
		money_disp="Twenty Five Lakh"
	if(mony==5000000):
		money_disp="Fifty Lakh"
	if(mony==10000000):
		money_disp="One Crore"
	
	if(mony>0):
		get_node("money").bbcode_text="[u]RS. "+money_disp+" Only"+"[/u]"
	else :
		get_node("money").bbcode_text="[u]"+money_disp+" Only[/u]"

func _on_ok_pressed():
	get_tree().change_scene("res://assets/scns/menu.tscn")


func _on_share_pressed():
	var link="https://play.google.com/store/apps/details?id=com.bitpix.kbc2019"
	OS.shell_open("whatsapp://send?text="+" Hello friends, I just won R$ " +money_disp+ " download the KBC app now and become a Crorepati "+link)
