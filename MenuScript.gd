extends CanvasLayer

var text_state = 1

func die(score=0):
	show()
	get_tree().paused = true
	$DeadText.show()
	text_state = 1
	$ScoreText.hide()
	$DeadText/Text2.text = 'score: ' + str(score)
	$AudioStreamPlayer.play()
	

func _ready():
	get_tree().paused = true

func start_game():
	get_tree().paused = false
	$DeadText.hide()
	$PlayText.hide()
	$ScoreText.show()
	get_parent().get_node('Player')._ready()
	for obstacle in get_parent().get_node('Obstacles').get_children():
		obstacle.queue_free()
	text_state = 0
	get_parent().obstacle_frequency = 4
	get_parent().obstacle_level = 2

func _input(event):
	if event == InputEventKey and bool(text_state):
		start_game()

func _process(delta):
	if Input.is_action_just_pressed("rotate") and bool(text_state):
		start_game()

