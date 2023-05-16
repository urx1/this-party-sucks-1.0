class_name Player
extends Area2D


signal hit
var timeout = GameManager.timeout
var points = GameManager.points
var special2 = GameManager.special2
var lean_degrees : int

var loser = false
export var speed = 250 #movespeed, export var to editor
var screen_size #game window size


func _ready(): #when game is launched
	screen_size = get_viewport_rect().size  #get screen size from settings
	hide()



func _process(delta):
	if loser == false:
		var velocity = Vector2.ZERO #player's movement vector, set velocity to 0
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1		
		if Input.is_action_just_released("special1"):
			dash()
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed #stop faster diagonal movement
		position += velocity * delta #establish starting position
		position.x = clamp(position.x, -5, screen_size.x) #bind player to screen
		position.y = clamp(position.y, 25, (screen_size.y - 50)) #bind player to screen
		if Input.is_action_pressed("lean_left"):
			lean(90)
		else:
			lean(0)
		if Input.is_action_pressed("lean_right"):
			lean(-90)
		else:
			lean(0)
		if Input.is_action_just_pressed("special2"):
			if GameManager.special2 > 0:
				set_collision_layer_bit(0, false)
				set_collision_mask_bit (0, false)
				set_collision_layer_bit(1, true)
				set_collision_mask_bit (1, true)
				GameManager.decrease_special2(1)
				$AnimatedSprite.animation = "special2"
			else:
				pass
			$Special2Timer.start()
			$AnimatedSprite.playing = true
			$AnimatedSprite.flip_h = velocity.x < 0 
		if Input.is_action_just_pressed("pause"):
			get_tree().paused = true
	else:
		pass


func _on_Player_body_entered(body):
	if body is Mob or Mob2 or Mob3:
		#hide() #remove player from screen when hit
		emit_signal("hit") #emit the hit signal
		$CollisionShape2D.set_deferred("disabled", true) #disable when hit to avoid further hits
		$AnimatedSprite.rotation_degrees = 0
		$CollisionShape2D.rotation_degrees = 0
		$AnimatedSprite.animation = "end"
		loser = true
		$osuma.play()

		
func _on_Player_area_entered(area: Area2D): #_area: Area2D
	if area is Pickup:
		GameManager.add_points(1)
		$sipsi.play()
	if area is Pickup2:
		GameManager.add_timeout(5)
		$kalja.play()
	if area is Pickup3:
		GameManager.add_special2(1)
		$kakku.play()

	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false #enable collisionshape again
	loser = false
	$AnimatedSprite.animation = "anim1"

func dash():
	if GameManager.points > 0:
		speed += 750
		$Special1Timer.start()
		GameManager.decrease_points(1)
	else:
		#$HUD/CountDownLabel.set("custom_colors/default_color", Color(0,0,1,1))
		pass


func lean(lean_degrees):
	if lean_degrees >= -90:
		set_rotation_degrees(lerp(get_rotation_degrees(), min(lean_degrees, get_rotation_degrees()), 0.02))
	if lean_degrees <= 90:
		set_rotation_degrees(lerp(get_rotation_degrees(), max(lean_degrees, get_rotation_degrees()), 0.02))


func _on_Special1Timer_timeout():
	speed = 250
	

func _on_Special2Timer_timeout():
	set_collision_layer_bit(0, true)
	set_collision_mask_bit (0, true)
	set_collision_layer_bit(1, true)
	set_collision_mask_bit (1, true)
	$AnimatedSprite.animation = "anim1"
