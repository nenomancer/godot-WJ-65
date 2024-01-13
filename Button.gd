extends Polygon2D

const red = Color(1, 0, 0)
const orange = Color(1, 0.45, 0)
const yellow = Color(1, 1, 0)

const green = Color(0.3, 1, 0)
const jade = Color(0, 1, 0.4)
const turquoise = Color(0, 1, 1)

const baby_blue = Color(0, 0.6, 1)
const blue = Color(0.1, 0.1, 1)
const purple = Color(0.75, 0, 1)

const pink = Color(1, 0, 0.9)
const salmon = Color(1, 0, 0.45)

const colors = [green, jade, turquoise, baby_blue, blue, purple, pink, salmon]
const test_colors = [purple, blue]



# Called when the node enters the scene tree for the first time.
func _ready():
	#var color = Color(1, 0, 0)
	color = colors[randi_range(0, colors.size() - 1)]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_released("left_click"):
		set_color(test_colors[randi_range(0, test_colors.size() - 1)])
		#set_color(colors[randi_range(0, colors.size() - 1)])
