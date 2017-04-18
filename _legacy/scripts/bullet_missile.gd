
extends RigidBody2D

const Speed = 24
const Damage = 5


const amp = 6
var rise = -2.0

var Y


onready var sploder = preload('res://resources/mob_sploder.tscn')
onready var world = get_node('../../../')

func _ready():
	Y = get_pos().y
	if randf() > 0.5:	rise = -rise


func Fire(owner,dir):
	#owner=who fired this bullet
	#dir=Vector2 direction of fire
	
	#add bullet to the world
	owner.world.add_bullet(self)
	
	var pos = owner.get_global_pos()
	#step us forward such pixels
	pos += dir.normalized()*4.0
	pos.y += 1.0
	set_global_pos(pos)
	get_node('Sprite').set_scale(Vector2(1*sign(dir.x),1))

	#PS2D.body_add_collision_exception(owner.get_rid(),get_rid())
	dir = dir.normalized()*Speed
	set_linear_velocity(dir)
	set_process(true)

func _process(delta):
	var lv = get_linear_velocity()
	lv.x *= 1.005
	lv.y += rise
	
	if rise > 0 and lv.y > Y+(amp*(abs(lv.x)/Speed)):
		rise = -rise

	elif rise < 0 and lv.y < Y-(amp*(abs(lv.x)/Speed)):
		rise = -rise

	set_linear_velocity(lv)
	if lv.x >= Speed*10:
		set_process(false)

func Hit(target=null):
	var S = sploder.instance()
	get_parent().add_child(S)
	S.set_global_pos(get_global_pos())
	_remove()

func _on_visibility_exit_screen():
	#we have left the screen
	_remove()


func _on_area_body_enter( body ):
	if not body extends preload('res://scripts/player.gd'):
		if body.has_method('mob_get_hit'):
			body.mob_get_hit(Damage)
		Hit()

func _remove():
	#parti.set_emitting(false)
	queue_free()
