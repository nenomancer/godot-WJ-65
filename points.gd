extends Label

var current_points: int = 0
func _ready():
	#text = "Points: " + str(current_points)
	update_points()


func _on_main_container_update_poinz(point_amount):
	current_points += point_amount
	print("UPDATIN")
	update_points()

func update_points():
	text = "Pointssdad: " + str(current_points)
	
