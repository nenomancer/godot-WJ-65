extends Container
# Called when the node enters the scene tree for the first time.
const BUTTON = preload("res://button.tscn")

const audio_data = preload("res://Assets/audio_data.gd")
const color_data = preload("res://Assets/color_data.gd")

#const colors = [green, jade, turquoise, baby_blue, blue, purple, pink, salmon]
var colors: Array = color_data.DATA
const sounds: Dictionary = audio_data.DATA

var buttons: Array
var index = 0
var sound_color_pairs = {
	# note: String,
	# sound: AudioStreamWAV,
	# color: Color
}

var correct_color: Color
var correct_sound: AudioStreamWAV

func _ready():
	
	generate_color_pairs(12, 1)
	print(sound_color_pairs.keys())
	generate_buttons(6)
	var i = 0
	for sound in sound_color_pairs:
		var new_button = BUTTON.instantiate()
		var text_color: Color = Color.BLACK
		
		var luminance = sound_color_pairs[sound].color.get_luminance()
		if luminance <= 0.5:
			text_color = Color.WHITE
		#elif luminance >= 0.5:
			#print("this is a light color")
			#text_color = Color.BLACK			
		
		new_button.configure_button(sound_color_pairs[sound].sound, sound_color_pairs[sound].color, sound, sound_color_pairs.values()[i].color)
	
		#$Colors.add_cshild(new_button)
		i += 1
		
	buttons = $Colors.get_children()
	var correct_index = randi_range(0, buttons.size() - 1)
	print('button size: ', buttons.size(), ' correct index: ', correct_index)
	
	for button in buttons:
		var target_sound = button.get_node("Sound").stream
		button.color_clicked.connect(Callable(handle_button).bind(button))
		for sound in sound_color_pairs:
			var audition_sound = sound_color_pairs[sound].sound
			if(audition_sound == target_sound):
				var new_color = sound_color_pairs[sound].color
				var new_text = sound
				button.get_node("Color").color = new_color
				button.get_node("NoteName").text = new_text
				button.color_value = new_color
				button.color_hover = new_color.lightened(0.1)
		if correct_index == button.get_index():
			# Set the correct answer
			correct_color = button.get_node("Color").color
			correct_sound = button.get_node("Sound").stream
			$CorrectNote.text = "Correct note: " + button.get_node("NoteName").text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func generate_buttons(number_of_buttons: int):
	var i = 0
	var index_array: Array
	while i < number_of_buttons:
		# 0
		# sound_color_pairs[0]
		var indexx = randi_range(0, sound_color_pairs.values().size() - 1)
		index_array.append(indexx)
		print("Sound color pairs :", sound_color_pairs.values()[indexx], ', index: ', indexx)
		print("Sound and color pairs: ", sound_color_pairs.values().size())
		var new_button = BUTTON.instantiate()
		var text_color: Color = Color.BLACK
		var new_color: Color = sound_color_pairs.values()[indexx].color
		var new_sound: AudioStreamWAV = sound_color_pairs.values()[indexx].sound
		var new_label: String = sound_color_pairs.values()[indexx].note
		new_button.color_value = new_color
		new_button.color_hover = new_color.lightened(0.5)
		
		#var luminance = sound_color_pairs[indexx].color.get_luminance()
		#if luminance <= 0.5:
			#text_color = Color.WHITE
		
		new_button.configure_button(new_sound, new_color, new_label, Color.OLD_LACE)
		sound_color_pairs.erase(sound_color_pairs.keys()[indexx])
		$Colors.add_child(new_button)
		i += 1

func handle_button(button):
	if correct_sound == button.get_node("Sound").stream:
		print("You guessed the CORRECT color")
	else:
		print("You guessed the WRONG color")
	
func generate_color_pairs(note_range: int = 3, semitone_skip: int = 4):
	var index = 0
	for i in note_range:
		sound_color_pairs[sounds.keys()[index]] = {
			note = sounds.keys()[index],
			sound = sounds.values()[index],
			color = colors[index],
		}
		index = (index + semitone_skip) % sounds.size() # Every OTHER note (in this case: C, E, G)

func mix_color(colors: Array[Color]) -> Color:
	# Mix two or more Colors
	var new_color: Color
	var color_sum: Color
	
	for color in colors:
		color_sum += color
	return color_sum / colors.size()
	

