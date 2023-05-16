extends Timer



func _on_Pickup3Timer_timeout() -> void:
	randomize()
	self.wait_time = 8
	self.wait_time += randi() % 3
	print("!!!")
	print(self.wait_time)
	print("!!!")
