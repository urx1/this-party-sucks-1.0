extends CanvasLayer


signal start_game
signal show_info


var timeout = GameManager.timeout


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	#$MessageTimer.start()
	
	
func show_game_over():
	$EndScreen.show()
	show_message("NEW GAME?")
	#wait for countdown
	#yield($MessageTimer, "timeout")
	$MessageLabel.text = "Your score:"
	$MessageLabel.show()
	$ScoreLabel.show()
	#One shot timer with countdown
	#yield(get_tree().create_timer(1), "timeout")
	$StartGameButton.show()
	


func update_score(score):
	$ScoreLabel.text = str(score)
	
	
func update_points(points):
	if points <= 0:
		$PointsLabel.set("custom_colors/font_color", Color(1, 0, 0, 1))
		$DashLabel.set("custom_colors/font_color", Color(1, 0, 0, 1))
	else: 
		$PointsLabel.set("custom_colors/font_color", Color(0, 1, 0.06, 1))
		$DashLabel.set("custom_colors/font_color", Color(0, 1, 0.06, 1))
	$PointsLabel.text = str(points)

func update_special2(special2):
	if special2 <= 0:
		$Special2Label.set("custom_colors/font_color", Color(1, 0, 0, 1))
		$Special2Label2.set("custom_colors/font_color", Color(1, 0, 0, 1))
	else: 
		$Special2Label.set("custom_colors/font_color", Color(0, 1, 0.06, 1))
		$Special2Label2.set("custom_colors/font_color", Color(0, 1, 0.06, 1))
	$Special2Label.text = str(special2)
	
func _on_StartButton_pressed():
	$StartScreen.hide()
	$StartButton.hide()
	$InfoScreen.show()
	$StartGameButton.show()
	$MessageLabel.hide()
	$InfoLabel1.show()
	$InfoLabel2.show()
#	$InfoLabel3.show()#


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	
	
func timeout_update(timeout):
	if timeout <= 5:
		$CountDownLabel.set("custom_colors/font_color", Color(1, 0, 0, 1))
		$TimeOutLabel.set("custom_colors/font_color", Color(1, 0, 0, 1))
	elif timeout <= 10:
		$CountDownLabel.set("custom_colors/font_color", Color(0.87, 0.76, 0.01, 1))
		$TimeOutLabel.set("custom_colors/font_color", Color(0.87, 0.76, 0.01, 1))
	else:
		$CountDownLabel.set("custom_colors/font_color", Color(0, 1, 0.06, 1))
		$TimeOutLabel.set("custom_colors/font_color", Color(0, 1, 0.06, 1))
	$TimeOutLabel.text = str(timeout)


func _on_StartGameButton_pressed():
	$InfoScreen.hide()
	$StartGameButton.hide()
	$EndScreen.hide()
	$ScoreLabel.hide()
	$CountDownLabel.set("custom_colors/font_color", Color(1,1,1,1))
	emit_signal("start_game")



