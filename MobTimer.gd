extends Timer


func _on_SpawnFreqTimer_timeout():
	if self.wait_time <= 0.8:
		self.wait_time += 0
		print("LIMIT")
	else:
		self.wait_time -= 0.1
		print(self.wait_time)
		print("SPAWN1 INCREASED")
