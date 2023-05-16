extends Timer


func _on_SpawnFreqTimer_timeout():
	if self.wait_time <= 0.6:
		self.wait_time += 0
		print("LIMIT")
	else:
		self.wait_time -= 0.15
		print("SPAWN3 INCREASED")
	#pass
