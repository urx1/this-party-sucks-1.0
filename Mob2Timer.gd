extends Timer






func _on_SpawnFreqTimer_timeout():
	if self.wait_time <= 0.7:
		self.wait_time += 0
		print("LIMIT")
	else:
		self.wait_time -= 0.15
		print(self.wait_time)
		print("SPAWN2 INCREASED")
