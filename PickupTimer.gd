extends Timer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"




func _on_PickupTimer_timeout() -> void:
	randomize()
	self.wait_time = 4
	self.wait_time += randi() % 2
	print(self.wait_time)
