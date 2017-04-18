
extends RigidBody2D

const Speed = 242
const Damage = 1

onready var sploder = preload('res://resources/bullet_sploder.tscn')

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

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

	#PS2D.body_add_collision_exception(owner.get_rid(),get_rid())
	dir = dir.normalized()*Speed
	set_linear_velocity(dir)

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
	queue_free()
