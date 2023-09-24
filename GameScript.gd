extends Node2D

var obstacle_variants = [preload("res://ObstacleVariants/obstacle_var_1.tscn"), preload("res://ObstacleVariants/obstacle_var_2.tscn"), preload("res://ObstacleVariants/obstacle_var_3.tscn")]

var difficulty_stages = [[3, 3, -6], [2, 3, -8], [1.5, 3, -10]] #frequency, types/level, player speed

var obstacle_spawn_xpos = 360
var obstacle_frequency = 4
var obstacle_level = 2

var timer = 0

func _ready():
	randomize()

func _process(delta):
	#position setting
	$Camera2D.global_position.y = $Player.global_position.y
	$Environment.global_position.y = $Player.global_position.y - 941
	$DeleteArea.global_position.y = $Player.global_position.y - 500
	
	#obstacle spawning
	if timer >= obstacle_frequency:
		var obstacle_instance = obstacle_variants[randi() % obstacle_level].instantiate()
		obstacle_instance.global_position = Vector2(obstacle_spawn_xpos, $Player.global_position.y - 1000)
		$Obstacles.add_child(obstacle_instance)
		timer = 0
	timer += delta
	
	#difficulty scaling
	if $Player.score > 700 :
		obstacle_frequency = difficulty_stages[0][0]
		obstacle_level = difficulty_stages[0][1]
		$Player.y_speed = difficulty_stages[0][2]
	if $Player.score > 1400 :
		obstacle_frequency = difficulty_stages[1][0]
		obstacle_level = difficulty_stages[1][1]
		$Player.y_speed = difficulty_stages[1][2]
	if $Player.score > 2400 :
		obstacle_frequency = difficulty_stages[1][0]
		obstacle_level = difficulty_stages[1][1]
		$Player.y_speed = difficulty_stages[1][2]
	
