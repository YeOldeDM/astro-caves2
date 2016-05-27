
extends Node2D

var shake_amp = 4
var shake_falloff = 8

var MAPSET = "caves"

# Set this for initial NewGame position
var current_position = Vector2(0,0) setget _set_map


onready var map_holder = get_node('current_map')


func _set_map(pos):
	# default to our current map.
	# otherwise we're warping to
	# this position
	if pos != current_position:
		
		_spawnmap(pos.x,pos.y)
	current_position = pos


func add_bullet(bullet):
	add_child(bullet)




# Make the world screen shake
# Also seems to halt gameplay while shaking
# so use sparingly!!
func start_shake(amp,falloff):
	shake_amp = amp
	shake_falloff = falloff
	set_process(true)

func _Shake(amt):
	var x = rand_range(-amt,amt)
	var y = rand_range(-amt,amt)
	set_pos(Vector2(x,y))


func _process(delta):
	if shake_amp >= 0:
		_Shake(shake_amp)
	else:
		set_process(false)
	shake_amp -= delta*shake_falloff

func _spawnmap(x,y):
	# load the pending map
	var ref = 'res://maps/'+MAPSET+'_'+str(x)+'_'+str(y)+'.tscn'
	var map = load(ref)
	# check if the map exists before trying to instance it
	if ResourceLoader.has(ref):
		# free the old map first..
		if !map_holder.get_children().empty():
			for i in map_holder.get_children():
				i.queue_free()
		# ..and add the new map
		map_holder.add_child(map.instance())
	# Throw an annoying Error in our face if we get invalid coordinates
	else:	OS.alert("accessing bad map coords at x:"+str(x)+" y:"+str(y))
		

func _ready():
	_spawnmap(current_position.x,current_position.y)