extends Node

var points : int setget add_points, get_points
var timeout = 15
var special2 : int setget add_special2, get_special2

func _ready():
	reset_points()
	reset_timeout()
	reset_special2()

func add_points(amount):
	points += amount
	#timeout += 5
	
func decrease_points(amount):
	points -= amount

func get_points():
	return points

func reset_points():
	points = 0

func get_timeout():
	return timeout

func reset_timeout():
	timeout = 15

func add_timeout(amount):
	timeout += amount
	
func decrease_timeout(amount):
	timeout -= amount

func add_special2(amount):
	special2 += amount
	#timeout += 5
	
func decrease_special2(amount):
	special2 -= amount

func get_special2():
	return special2

func reset_special2():
	special2 = 0
