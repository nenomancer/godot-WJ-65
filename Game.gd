extends Node2D
const AudioData = preload("res://audio/AudioData.gd")
# Called when the node enters the scene tree for the first time.
const BUTTON = preload("res://ColorButton.tscn")
func _ready():
	var new_button = BUTTON.instantiate()
	new_button.position = Vector2(250, 250)
	add_child(new_button)
	
	$AudioStreamPlayer.stream = AudioData.DATA[randi_range(0, AudioData.DATA.size() - 1)]
	$AudioStreamPlayer.playing = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
