class_name Mob2
extends RigidBody2D


func _ready():
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names() #get animations as array
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] #get random integer between 0-2


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
