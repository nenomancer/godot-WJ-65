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

var correct_index: int
var correct_color: Color
var correct_sound: AudioStreamWAV

func _ready():
	generate_color_pairs(12, 1)
	print(sound_color_pairs.keys())
	
	buttons = $Colors.get_children()
	if buttons.size() > 0:
		load_buttons()	
		
	# Use to randomly generate buttons
	#generate_buttons(3)
	var i = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_correct_answer(button: MarginContainer):
	correct_color = button.get_node("Color").color
	correct_sound = button.get_node("Sound").stream
	$CorrectNote.text = "Correct note: " + button.get_node("NoteName").text

func load_buttons():
	correct_index = randi_range(0, buttons.size() - 1)
	
	for button in buttons:
		var target_sound = button.get_node("Sound").stream
		button.color_clicked.connect(Callable(handle_button_click.bind(button)))
		
		for key in sound_color_pairs:
			var audition_sound = sound_color_pairs[key].sound
			if(audition_sound == target_sound):
				var text_color = Color.BLACK
				var new_color = sound_color_pairs[key].color
				var new_text = key
				button.color_hover = new_color.lightened(0.5)
				var sound = button.get_node("Sound").stream
				
				button.configure_button(sound, new_color, new_text, text_color)
				#button.get_node("Color").color = new_color
				#button.get_node("NoteName").text = new_text
				#button.color_value = new_color
				
		if correct_index == button.get_index():
			set_correct_answer(button)

func generate_buttons(number_of_buttons: int):
	var i = 0
	var index_array: Array
	correct_index = randi_range(0, number_of_buttons - 1)
	print("CORRECT INDEX: ", correct_index)
	
	while i < number_of_buttons:
		# 0
		# sound_color_pairs[0]
		var indexx = randi_range(0, sound_color_pairs.values().size() - 1)
		index_array.append(indexx)
		
		var new_button = BUTTON.instantiate()
		
		var text_color: Color = Color.BLACK
		var new_color: Color = sound_color_pairs.values()[indexx].color
		var new_sound: AudioStreamWAV = sound_color_pairs.values()[indexx].sound
		var new_label: String = sound_color_pairs.values()[indexx].note
		
		new_button.color_value = new_color
		new_button.color_hover = new_color.lightened(0.5)
		new_button.color_clicked.connect(Callable(handle_button_click).bind(new_button))
		
		new_button.configure_button(new_sound, new_color, new_label, text_color)
		
		if correct_index == i: 
			set_correct_answer(new_button)
		
		#var luminance = sound_color_pairs[indexx].color.get_luminance()
		#if luminance <= 0.5:
			#text_color = Color.WHITE
		
		sound_color_pairs.erase(sound_color_pairs.keys()[indexx])
		$Colors.add_child(new_button)
		i += 1

func handle_button_click(button):
	print('Button: ', button, ', correct sound: ', correct_sound, ', button sound: ', button.get_node("Sound").stream)
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
	

