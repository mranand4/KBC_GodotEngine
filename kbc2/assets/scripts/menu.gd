extends Node2D

onready var button_tween = $button_tween
onready var button_tween_op = $button_tween_op
onready var credits_tween=$credits_tween
var button_id=-1
var ques_loaded=0

var x = 0
var tq=-1
var re_timer=15

var admob=null
var isReal = true
var isTop = false
var adBannerId = "xxxxxxxx"
var adRewardedId = "xxxxxxxx"
var adInterstitialId = "xxxxxxxx"



func _ready():
	print(global_script.rew_ads_count)
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
		loadBanner()
		if(global_script.rew_ads_count%2!=0):
			loadRewardedVideo()
		#else:
		#	loadInterstitial()
	get_tree().connect("screen_resized", self, "onResize")
	global_script.rew_ads_count+=1
	randomize()
	global_script._set_initial()
	VisualServer.set_default_clear_color(Color(0,0,0))
	$background.hide()
	$buttons.hide()
	$total_ques.request("https://raw.githubusercontent.com/ShivanshAnand/millionaire_godot/master/tq.txt")
	global_script._set_initial_ques_number()
	
# ads start

#banner
func loadBanner():
	if admob != null:
		admob.loadBanner(adBannerId, isTop)

func showBanner():
	if admob!=null:
		admob.showBanner()
#banner end
#inter
#func loadInterstitial():
#	if admob != null:
#		admob.loadInterstitial(adInterstitialId)
#
#func _showInter():
#	admob.showInterstitial()
#
#func _on_interstitial_not_loaded():
#	print("Error: Interstitial not loaded")
#
#func _on_interstitial_loaded():
#	print("Interstitial ad loaded")
#	_showInter()

#inter end

#rewarded
func loadRewardedVideo():
	if admob != null:
		admob.loadRewardedVideo(adRewardedId)


func _on_rewarded_video_ad_loaded():
	print("Rewarded loaded success")
	if admob != null:
		admob.showRewardedVideo()

func _on_rewarded_video_ad_closed():
	print("Rewarded close")

#rewarded end
func onResize():
	if admob != null:
		admob.resize()

#ads end

func _start_button_tween():
	button_tween.interpolate_property($buttons,"position",$buttons.position,Vector2(367,$buttons.position.y),1.2,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
	button_tween.start()

#buttons

func _on_play_button_pressed():
	button_id=0
	button_tween_op.interpolate_property($buttons,"position",$buttons.position,Vector2(-320,$buttons.position.y),0.5,Tween.TRANS_CUBIC,Tween.EASE_IN)
	button_tween_op.start()
	$buttons/button_click.play(0)

func _on_credits_button_pressed():
	button_id=1
	button_tween_op.interpolate_property($buttons,"position",$buttons.position,Vector2(-320,$buttons.position.y),0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
	button_tween_op.start()
	$buttons/button_click.play(0)
	
func _on_htp_button_pressed():
	button_id=2
	var link="https://play.google.com/store/apps/details?id=com.bitpix.kbc2019"
	OS.shell_open("whatsapp://send?text="+" Hello friends, download the KBC app now and become a Crorepati "+link)

func _on_rate_button_pressed():
	button_id=3
	OS.shell_open("https://play.google.com/store/apps/details?id=com.bitpix.kbc2019")


func _on_back_button_pressed():
	_start_button_tween()
	credits_tween.interpolate_property($credits,"position",$credits.position,Vector2(1040,256),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	credits_tween.start()
	$buttons/button_click.play(0)

func _on_button_tween_op_tween_completed(object, key):
	if(button_id==0):
		get_tree().change_scene("res://assets/scns/question.tscn")
	if(button_id==1):
		credits_tween.interpolate_property($credits,"position",$credits.position,Vector2(230,256),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
		credits_tween.start()
	if(button_id==2):
		pass
	if(button_id==3):
		var url_front="https://play.google.com/store/apps/details?id="
		var url_app_id="com.bitpix.kbc2019"
		OS.shell_open(url_front+url_app_id)

# GETTING QUESTIONS FROM SERVER

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	global_script._get_questions(json)
	var a = $HTTPRequest.get_downloaded_bytes()
	if(a>0):
		$main_theme.play(0.0)
		$background.show()
		$buttons.show()
		$loading.hide()
		$reload_button.hide()
		_start_button_tween()

func _on_total_ques_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var gb = $total_ques.get_downloaded_bytes()
	var gbi=int(gb)
	if(gb>0):
		tq=json.result.tq
	if(tq>=0):
		var a = str(int(rand_range(0,tq)))
		$Label.text=a+","+str(tq)+","+str(gbi)
		$HTTPRequest.request("https://raw.githubusercontent.com/ShivanshAnand/millionaire_godot/master/"+str(a)+".txt")


func _on_reload_button_pressed():
	get_tree().reload_current_scene()


func _on_reconnect_timeout():
	if(tq<0):
		if(re_timer>0):
			re_timer=re_timer-1
		else:
			$total_ques.request("https://raw.githubusercontent.com/ShivanshAnand/millionaire_godot/master/tq.txt")
			re_timer=15
			get_node("reconnect").queue_free()
