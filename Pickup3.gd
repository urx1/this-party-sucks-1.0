class_name Pickup3
extends Area2D

#onready var Player = $Player

func _ready():
	$Pickup3RemoveTimer.start()


#func _on_PickupTest_body_entered(body):
#	if body is Player:
#		hide()
#		queue_free()
#	else:
#		pass


func _on_Pickup3_area_entered(area: Area2D):
		hide()
		queue_free()

func _on_Pickup3RemoveTimer_timeout():
	self.hide()
	self.queue_free()

