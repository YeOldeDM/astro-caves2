
extends RigidBody2D

var Life = 1

var sploder_obj = preload('res://resources/mob_sploder.tscn')
onready var world = get_node('../../../../')


func mob_get_hit(dmg):
	var new_life = Life - dmg
	if new_life <= 0:
		_kill()
	else:
		Life = new_life

func _kill():
	var sploder = sploder_obj.instance()
	get_parent().add_child(sploder)
	sploder.set_pos(get_pos())
	queue_free()


