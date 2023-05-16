extends Node


export(PackedScene) var mob_scene
export(PackedScene) var mob2_scene
export(PackedScene) var mob3_scene
export(PackedScene) var pickup_scene
export(PackedScene) var pickup2_scene
export(PackedScene) var pickup3_scene


var score
var points
var timeout# = GameManager.timeout
var special2


func _ready():
	randomize()
	$HUD/PointsLabel.hide()
	$HUD/Special2Label.hide()
	$HUD/ScoreLabel.hide()
	$HUD/TimeOutLabel.hide()
	$HUD/InfoScreen.hide()
	$HUD/StartGameButton.hide()
	$HUD/EndScreen.hide()
	$HUD/CountDownLabel.hide()
	$HUD/DashLabel.hide()
	$HUD/Special2Label2.hide()
	$HUD/InfoLabel1.hide()
	$HUD/InfoLabel2.hide()
#	$HUD/InfoLabel3.hide()
	
	
func _process(_delta):
	points = GameManager.get_points()
	timeout = GameManager.get_timeout()
	special2 = GameManager.get_special2()
	update_points()
	update_special2()
	update_timeout()
	timeWarning()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	#if GameManager.timeout <= 15:
		#$TimeoutWarning.play()


func game_over():
	$HUD.show_game_over()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Mob2Timer.stop()
	$Mob3Timer.stop()
	$Mob2SpawnTimer.stop()
	$Mob3SpawnTimer.stop()
	$PickupTimer.stop()
	$Pickup2Timer.stop()
	$Pickup3Timer.stop()
	$SpawnFreqTimer.stop()
	$Mob3Timer.stop()
	$TimeOutTimer.stop()
	$HUD/PointsLabel.hide()
	$HUD/Special2Label.hide()
	#$HUD/ScoreLabel.hide()
	$HUD/TimeOutLabel.hide()
	$HUD/CountDownLabel.hide()
	$HUD/DashLabel.hide()
	$HUD/Special2Label2.hide()
	$Music.stop()
	$HUD/InfoLabel1.hide()
	Physics2DServer.set_active(true)
	
func gameLost():
	Physics2DServer.set_active(false)
	yield(get_tree().create_timer(0.75), 'timeout')
	game_over()



func new_game():
	score = 0
	points = 0
	special2 = 0
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("pickups", "queue_free")
	$MobTimer.wait_time = 2
	$Mob2Timer.wait_time = 3.5
	$Mob3Timer.wait_time = 5
	$PickupTimer.wait_time = 4
	$Pickup2Timer.wait_time = 2
	$Pickup3Timer.wait_time = 8
	$SpawnFreqTimer.wait_time = 5
	$HUD/StartScreen.hide()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$PickupTimer.start() 
	$Pickup2Timer.start()
	$Pickup3Timer.start()
	$HUD.update_score(score)
	$HUD.update_points(points)
	$HUD.update_special2(special2)
	#$HUD.show_message("Get Ready")
	GameManager.reset_points()
	GameManager.reset_timeout()
	GameManager.reset_special2()
	$HUD/MessageLabel.hide()
	$HUD/PointsLabel.show()
	$HUD/Special2Label.show()
	#$HUD/ScoreLabel.show()
	$HUD/TimeOutLabel.show()
	$TimeOutTimer.start()
	$HUD.timeout_update(timeout)
	$HUD/CountDownLabel.show()
	$HUD/DashLabel.show()
	$HUD/Special2Label2.show()
	$HUD/InfoLabel1.hide()
	$HUD/InfoLabel2.hide()
#	$HUD/InfoLabel3.hide()
	$Music.play()
	if $HUD/InfoScreen/soundCheck.pressed == true:
		var master_sound = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_sound, true)
	elif $HUD/InfoScreen/soundCheck.pressed == false:
		var master_sound = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_sound, false)
	else:
		pass



func _on_MobTimer_timeout():
	#create instance of mob scene
	var mob = mob_scene.instance()
	#choose random location on path2d
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	#set direction perpendicular in relation to path
	var direction = mob_spawn_location.rotation + PI / 2
	#set mob's position to random
	mob.position = mob_spawn_location.position
	#add randomness to direction
	direction += rand_range(-PI / 4, PI / 4)
	#mob.rotation = direction
	#choose mob's velocity
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	#spawn mob
	add_child(mob)


func _on_Mob2Timer_timeout():
		#create instance of mob scene
	var mob2 = mob2_scene.instance()
	#choose random location on path2d
	var mob2_spawn_location = get_node("Mob2Path/Mob2SpawnLocation")
	mob2_spawn_location.offset = randi()
	#set direction perpendicular in relation to path
	var direction = mob2_spawn_location.rotation + PI / 2
	#set mob's position to random
	mob2.position = mob2_spawn_location.position
	#add randomness to direction
	direction += rand_range(-PI / 4, PI / 4)
	#mob2.rotation = direction
	#choose mob's velocity
	var velocity = Vector2(rand_range(175.0, 275.0), 0.0)
	mob2.linear_velocity = velocity.rotated(direction)
	#spawn mob
	add_child(mob2)


func _on_Mob3Timer_timeout():
		#create instance of mob scene
	var mob3 = mob3_scene.instance()
	#choose random location on path2d
	var mob3_spawn_location = get_node("Mob3Path/Mob3SpawnLocation")
	mob3_spawn_location.offset = randi()
	#set direction perpendicular in relation to path
	var direction = mob3_spawn_location.rotation + PI / 1.5 #orig 2
	#set mob's position to random
	mob3.position = mob3_spawn_location.position
	#add randomness to direction
	#direction += rand_range(-PI / 4, PI / 4)
	#mob3.rotation = direction
	#choose mob's velocity
	var velocity = Vector2(rand_range(220.0, 400.0), 0.0)
	mob3.linear_velocity = velocity.rotated(direction)
	#spawn mob
	add_child(mob3)

func _on_PickupTimer_timeout():
#	$PickupRemoveTimer.start()
	var pickup = pickup_scene.instance()
	var pickup_spawn_location = get_node("PickupPath/PickupSpawnLocation")
	pickup_spawn_location.offset = randi()
	pickup.position = pickup_spawn_location.position
	add_child(pickup)
	#$PickupTimer.wait_time = randi() % 6 + 3
	#print($PickupTimer.wait_time)
	
func update_points():
	$HUD.update_points(points)
	
func update_special2():
	$HUD.update_special2(special2)

func update_timeout():
	$HUD.timeout_update(timeout)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$Mob2SpawnTimer.start()
	$Mob3SpawnTimer.start()
	$ScoreTimer.start()
	$PickupTimer.start()
	$Pickup2Timer.start()
	$SpawnFreqTimer.start()


func _on_Mob2SpawnTimer_timeout():
	$Mob2Timer.start()


func _on_Mob3SpawnTimer_timeout():
	$Mob3Timer.start()


func _on_TimeOutTimer_timeout():
	GameManager.decrease_timeout(1)
	if not timeout == 0:
		$HUD.timeout_update(timeout)
		$TimeOutTimer.start()
	else:
		$HUD.timeout_update(timeout)
		game_over()


func timeout_decrease():
	#timeout -= 1 #tää toimii tällä hetkellä
	#GameManager.timeout_decrease() #tää ei updatee labelia
	if not timeout == 0:
		GameManager.decrease_timeout(1)
		$TimeOutTimer.start()
	else:
		game_over()
	



func _on_Pickup2Timer_timeout():
	var pickup2 = pickup2_scene.instance()
	var pickup2_spawn_location = get_node("Pickup2Path/Pickup2SpawnLocation")
	pickup2_spawn_location.offset = randi()
	pickup2.position = pickup2_spawn_location.position
	add_child(pickup2)
	#$PickupTimer.wait_time = randi() % 6 + 3
	#print($PickupTimer.wait_time)


func _on_Pickup3Timer_timeout():
	var pickup3 = pickup3_scene.instance()
	var pickup3_spawn_location = get_node("Pickup2Path/Pickup2SpawnLocation")
	pickup3_spawn_location.offset = randi()
	pickup3.position = pickup3_spawn_location.position
	add_child(pickup3)

func timeWarning():
	if timeout <= 5:
		$HUD/CountDownLabel.set("custom_colors/default_color", Color(0,0,1,1))
	else:
				$HUD/CountDownLabel.set("custom_colors/default_color", Color(1,1,1,1))
