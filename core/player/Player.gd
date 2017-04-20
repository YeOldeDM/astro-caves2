extends KinematicBody2D

onready var sprite = get_node('Sprite')
onready var camera = get_node('Camera')
onready var laser_timer = get_node('LaserReload')


var G = Game.get_gravity()
var facing = 1 setget _set_facing

var laser_reload_time = [0.42, 0.12]

var upgrades = {
	'laser':	true,
	'laserboost': false,
	'autolaser': false,
	'speedup':	false,
	}

var can_fire = {
	'laser':	true,
	}

var trigger_held = {
	'laser':	false,
	}

var speed = [54, 86]


var joy_force = Vector2()
var hold_direction = false


func get_speed():
	return self.speed[int(self.upgrades.speedup)]

func get_laser_reload_time():
	return self.laser_reload_time[int(self.upgrades.laserboost)]


func fire_laser():
	# spawn bullet
	var bullet = preload('res://core/bullets/LaserBullet.tscn').instance()
	var pos = get_pos()
	pos.x += 4*self.facing
	var dir = Vector2(self.facing*280,0)
	get_parent().add_child(bullet)
	# fire bullet
	bullet.fire(self,pos,dir)
	
	# Fire control
	self.can_fire.laser = false
	laser_timer.start()



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
	Globals.player = self
	Game.player = self
	laser_timer.set_wait_time(get_laser_reload_time())
	set_fixed_process(true)
	set_process_input(true)
	set_process(true)
	
	Globals.Stats.set_upgrades(self.upgrades)


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
		if upgrades.laser && !upgrades.autolaser && can_fire.laser:
			fire_laser()


func _process(delta):
	self.trigger_held.laser = Input.is_action_pressed("fire_laser")
	if self.upgrades.autolaser && self.trigger_held.laser && can_fire.laser:
		fire_laser()


func _fixed_process(delta):
	var new_facing = self.facing

	
	
	
	var force = self.joy_force

	if force.length() > 1.0:
		force = force.normalized()
	
	force *= get_speed() * delta
	if !self.hold_direction:
		if force.x < 0: new_facing = -1
		if force.x > 0: new_facing = 1
	
	var motion = move(force)
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		force = n.slide(force)
	move(motion)
	
	

	if new_facing != self.facing:
		self.facing = new_facing

	


func _set_facing(what):
	facing = what
	sprite.set_scale(Vector2(facing,1))


func _on_LaserReload_timeout():
	self.can_fire.laser = true
	laser_timer.set_wait_time(get_laser_reload_time())
