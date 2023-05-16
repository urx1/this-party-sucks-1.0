class_name Pickup2
extends Area2D

var beer1 = preload("res://art/pickup2/KARHU-olut.png")
var beer2 = preload("res://art/pickup2/OLUT-olut.png")


func _ready():
	choose_sprite()
	$Pickup2RemoveTimer.start()

func choose_sprite():
	#var sprites = [beer1, beer2]
	#var activeSprite = sprites[randi() % sprites.size()]
	$Sprite.texture = (beer2) #


func _on_Pickup2_area_entered(area: Area2D):
	hide()
	queue_free()


func _on_Pickup2RemoveTimer_timeout():
	self.hide()
	self.queue_free()
