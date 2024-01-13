extends Node2D
# Called when the node enters the scene tree for the first time.
const BUTTON = preload("res://ColorButton.tscn")

const AudioData = preload("res://Assets/AudioData.gd")
const ColorData = preload("res://Assets/ColorData.gd")

#const colors = [green, jade, turquoise, baby_blue, blue, purple, pink, salmon]
var colors: Array = ColorData.DATA
const sounds: Dictionary = AudioData.DATA
var index = 0
var pairs = {
	
}

func _ready():
	
	generate_color_pairs()
	var i = 0
	for key in pairs:
		var new_button = BUTTON.instantiate()
	
		new_button.position = (Vector2((250 * i), 250))
		new_button.get_node("Color").color = pairs[key].color
		new_button.get_node("Sound").stream = pairs[key].sound
		
		add_child(new_button)
		i += 1
		
	
	#$AudioStreamPlayer.stream = AudioData.DATA.values()[randi_range(0, AudioData.DATA.size() - 1)]
	#$AudioStreamPlayer.playing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_color_pairs():
	var index = 0
	for i in range(3):
		#print(i, colors[i], sounds.keys()[i])
		pairs[sounds.keys()[index]] = {
			sound = sounds.values()[index],
			#color = colors[index],
			color = mix_color([colors[index], colors[index + 1]]),
		}
		index += 2
	#print(pairs)

func mix_color(colors: Array[Color]) -> Color:
	# Mix two or more Colors
	var new_color: Color
	var color_sum: Color
	
	for color in colors:
		color_sum += color
	return color_sum / colors.size()
