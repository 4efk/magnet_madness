extends CharacterBody2D

var x_speed = 10
var y_speed = -5


var score = 0
var rotation_state: int = 1
var collision

var stuck = false

func _ready():
	global_position = Vector2(360, 950)
	score = 0
	x_speed = 10
	stuck = false

func die():
	get_node('../CanvasLayer').die(int(score))

func _process(delta):
	if Input.is_action_just_pressed("rotate"):
		rotation_state = -rotation_state
	if Input.is_action_just_pressed("restart"):
		die()
		
	
	if x_speed == 0:
		$Sprite2D.rotation_degrees = 90
	else:
		$Sprite2D.rotation_degrees = 90 - (90 * rotation_state)
		print(x_speed / abs(x_speed))

func _physics_process(delta):
	score += .6
	get_parent().get_node('CanvasLayer/ScoreText').text = 'score: ' + str(int(score))
	
	collision = move_and_collide(Vector2(x_speed * rotation_state, y_speed))
	if collision:
		x_speed = 0
		if !stuck:
			$AudioStreamPlayer.play()
			stuck = true
