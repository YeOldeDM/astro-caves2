
extends RigidBody2D

var Life = 4

var dir = 1
var Speed = 28

onready var downray = get_node('CastDown')
onready var upray = get_node('CastUp')


var sploder_obj = preload('res://resources/mob_sploder.tscn')

func _ready():
	downray.add_exception(self)
	upray.add_exception(self)
	set_linear_velocity(Vector2(0,Speed))


func _integrate_forces(state):
	if downray.is_colliding():
		set_linear_velocity(Vector2(0,-Speed))
	if upray.is_colliding():
		set_linear_velocity(Vector2(0,Speed))

func mob_get_hit(dmg):
	var new_life = Life - dmg
	if new_life <= 0:
		_kill()
	else:
		Life = new_life
		get_node('/root/Game/CurrentScene/Main/World').start_shake(2,20)

func _kill():
	var sploder = sploder_obj.instance()
	
	get_parent().add_child(sploder)
	sploder.set_pos(get_pos())
	
	get_node('/root/Game/CurrentScene/Main/World').start_shake(4,12)
	
	queue_free()


