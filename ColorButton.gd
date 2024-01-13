extends MarginContainer

@onready var button_color = $Color
const ColorData = preload("res://Assets/ColorData.gd")
const red = Color(1, 0, 0, 1.0)
const orange = Color(1, 0.45, 0, 1.0)
const yellow = Color(1, 1, 0, 1.0)

const green = Color(0.3, 1, 0, 1.0)
const jade = Color(0, 1, 0.4, 1.0)
const turquoise = Color(0, 1, 1, 1.0)

const baby_blue = Color(0, 0.6, 1, 1.0)
const blue = Color(0.1, 0.1, 1, 1.0)
const purple = Color(0.75, 0, 1, 1.0)

const pink = Color(1, 0, 0.9, 1.0)
const salmon = Color(1, 0, 0.45, 1.0)


#const colors = [green, jade, turquoise, baby_blue, blue, purple, pink, salmon]
const test_colors = [purple, blue]
const colors = ColorData.DATA


# Called when the node enters the scene tree for the first time.
func _ready():
	#var color = Color(1, 0, 0)
	button_color.color = colors[randi_range(0, colors.size() - 1)]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func mix_color(colors: Array[Color]) -> Color:
	var new_color: Color
	var color_sum: Color
	
	for color in colors:
		color_sum += color
	return color_sum / colors.size()


func _on_button_button_up():
	# Change color on button click
	print(colors)
	button_color.set_color(colors[randi_range(0, colors.size() - 1)])
