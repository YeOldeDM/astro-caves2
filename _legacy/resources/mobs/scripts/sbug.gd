
extends KinematicBody2D

var SPEED = 35

var rotation = 0
var directions = {
		0:	Vector2(-1,0),
		90:	Vector2(0,1),
		180:	Vector2(1,0),
		270:	Vector2(0,-1)
		}

func _ready():
	set_fixed_process(true)
	get_node('Animator').play('walk')

func _fixed_process(delta):
	var pos = get_pos()
	var RAY_F = get_node('RayForward').is_colliding()
	var RAY_D = get_node('RayDown').is_colliding()

	if !RAY_D:
		turn_counterclockwise()
	else:
		pos = get_node('RayDown').get_collision_point()
	
	if RAY_F:
		turn_clockwise()
	
	if get_rot() != rotation:
		set_rotd(rotation)
	
	move(directions[rotation]*SPEED*delta)
	

func turn_clockwise():
	if rotation == 0:
		rotation = 270
	else:
		rotation -= 90
	set_pos(get_node('RayForward').get_collision_point())


func turn_counterclockwise():
	if rotation == 270:
		rotation = 0
	else:
		rotation += 90



