
extends Node

var SCREEN_RES = 4 setget _set_screenres

onready var scene = get_node('CurrentScene')

var first_scene = preload('res://main.tscn')

var using_joystick = false
var joy_device = 0
var joy_x_axis = 0
var joy_y_axis = 1

func get_current_scene():
	return scene.get_children()


func set_scene(scn):
	for scene in get_current_scene():
		scene.queue_free()
	var S = scn.instance()
	scene.add_child(S)

func Quit():
	get_tree().quit()



func _ready():
	set('SCREEN_RES', SCREEN_RES)
	if get_current_scene().empty():
		set_scene(first_scene)

func _set_screenres(mult):
	SCREEN_RES = mult
	var size = get_tree().get_root().get_rect().size
	print(size)
	size *= SCREEN_RES
	OS.set_window_size(size)



