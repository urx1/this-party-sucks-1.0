extends Timer

#func _ready():
#	randomize()
#	self.wait_time += randi() % 4


func _on_Pickup2Timer_timeout() -> void:
	randomize()
	self.wait_time = 3
	self.wait_time += randi() % 2
	print("!!!")
	print(self.wait_time)
	print("!!!")

