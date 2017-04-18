extends KinematicBody2D

onready var sprite = get_node('Sprite')
onready var camera = get_node('Camera')

var G = Game.get_gravity()
var facing = 1 setget _set_facing


var speed = 64


var joy_force = Vector2()
var hold_direction = false

func fire_laser():
	var bullet = preload('res://core/bullets/LaserBullet.tscn').instance()
	var pos = get_pos()
	pos.x += 4*self.facing
	var dir = Vector2(self.facing*280,0)
	get_parent().add_child(bullet)
	bullet.fire(self,pos,dir)

func set_room(room):
	print(room.get_name())
	var rect = room.get_shape(0).get_points()

	var minx = 9000
	var maxx = -9000
	var miny = 9000
	var maxy = -9000
	for point in rect:
		point += room.get_global_pos()
		minx = min(minx, point.x)
		maxx = max(maxx, point.x)
		miny = min(miny, point.y)
		maxy = max(maxy, point.y)
	
	
	camera.set_limit(0,minx)
	camera.set_limit(1,miny)
	camera.set_limit(2,maxx)
	camera.set_limit(3,maxy)

	prints(camera.get_limit(0),camera.get_limit(1),camera.get_limit(2),camera.get_limit(3))

func _ready():
	Game.player = self
	set_fixed_process(true)
	set_process_input(true)


func _input(event):
	if event.type == InputEvent.JOYSTICK_MOTION:
		if event.axis == 0:
			self.joy_force.x = event.value
		elif event.axis == 1:
			self.joy_force.y = event.value
	if event.is_action_pressed("hold_direction"):
		self.hold_direction = true
	if event.is_action_released("hold_direction"):
		self.hold_direction = false
	if event.is_action_pressed("fire_laser"):
		fire_laser()


func _fixed_process(delta):
	var new_facing = self.facing

	
	
	var force = self.joy_force

	if force.length() > 1.0:
		force = force.normalized()
	
	force *= speed * delta
	if !self.hold_direction:
		if force.x < 0: new_facing = -1
		if force.x > 0: new_facing = 1
	
	var motion = force
	if is_colliding():
		motion = get_collision_normal().slide(motion)
	move(motion)
	
	

	
	
	if new_facing != self.facing:
		self.facing = new_facing




func _set_facing(what):
	facing = what
	sprite.set_scale(Vector2(facing,1))
