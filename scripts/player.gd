
extends RigidBody2D

onready var game = get_node('/root/Game')
onready var world = get_parent()
var borders = Vector2(176,96)

var has_control = true


var Speed = 32
var Acelleration = 32
var Decelleration = 32

var facing = -1

var laser_time = 0.35
var laser_timer = 0.0
var can_laser = true

var missile_time = 0.45
var missile_timer = 0.0
var can_missile = true

var bullet_obj = preload('res://resources/bullet_standard.tscn')
var missile_obj = preload('res://resources/bullet_missile.tscn')

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var pos = get_global_pos()
	var map = world.current_position
	
	if pos.x < 0:
		set_global_pos(Vector2(borders.x,pos.y))
		world.set('current_position',\
				Vector2(map.x - 1, map.y))
		
		
	elif pos.x > borders.x+8:
		world.set('current_position',\
				Vector2(map.x + 1, map.y))
		set_pos(Vector2(8,pos.y))

	if pos.y < 0:
		world.set('current_position',\
				Vector2(map.x, map.y - 1))
		set_pos(Vector2(pos.x, borders.y - 8))
		
	elif pos.y > borders.y+8:
		world.set('current_position',\
				Vector2(map.x, map.y + 1))
		set_pos(Vector2(pos.x, 8))

func _integrate_forces(state):
	var lv = get_linear_velocity()
	var delta = state.get_step()



	var UP = Input.is_action_pressed('move_up')
	var DOWN = Input.is_action_pressed('move_down')
	var LEFT = Input.is_action_pressed('move_left')
	var RIGHT = Input.is_action_pressed('move_right')
	
	var FIRE_LASER = Input.is_action_pressed('fire_laser')
	var FIRE_MISSILE = Input.is_action_pressed('fire_missile')
	
	var HOLD = Input.is_action_pressed('hold_direction')
	
	if has_control and game.using_joystick:
		var joyx = Input.get_joy_axis(game.joy_device,game.joy_x_axis)
		var joyy = Input.get_joy_axis(game.joy_device,game.joy_y_axis)
		lv.x = joyx*Speed
		lv.y = joyy*Speed
		if !HOLD:
			if lv.x < 0:
				facing = -1
			elif lv.x > 0:
				facing = 1
		
	elif has_control:
		if UP:
			lv.y = -Speed
		if DOWN:
			lv.y = Speed
		if LEFT:
			lv.x = -Speed
			if !HOLD:
				facing = -1
		if RIGHT:
			lv.x = Speed
			if !HOLD:
				facing = 1
		
		if !UP and !DOWN:
			lv.y = 0
		if !LEFT and !RIGHT:
			lv.x = 0
	else:
		if lv != Vector2(0,0):
			lv = Vector2(0,0)
	
	lv = lv.normalized()*Speed

	set_linear_velocity(lv)
	get_node('Sprite').set_scale(Vector2(-facing,1))
	
	if FIRE_LASER && can_laser && has_control:
		can_laser = false
		var B = bullet_obj.instance()
		var dir = Vector2(facing,0)
		B.Fire(self,dir)
		get_node('sound').play('laser_bullet_fire')
	
	if FIRE_MISSILE && can_missile && has_control:
		can_missile = false
		var M = missile_obj.instance()
		var dir = Vector2(facing,0)
		M.Fire(self,dir)
		get_node('sound').play('laser_bullet_fire')
	
	if !can_laser:
		if laser_timer >= laser_time:
			laser_timer = 0.0
			can_laser = true
		else:	laser_timer += delta

	if !can_missile:
		if missile_timer >= missile_time:
			missile_timer = 0.0
			can_missile = true
		else:	missile_timer += delta
