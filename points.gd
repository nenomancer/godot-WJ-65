extends Label

var current_points: int = 0
func _ready():
	#update_points()
	pass

#func update_points():
	#text = "Points: " + str(current_points)
	#


func _on_main_container_update_points(point_amount):
	current_points += point_amount
	print("UPDATIN")
	text = "Points: " + str(current_points)
	
	pass # Replace with function body.
