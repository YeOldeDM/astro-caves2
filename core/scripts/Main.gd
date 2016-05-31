
extends Node


var config
var configPath = 'res://config.ini'

onready var main = get_node('/root/Main')
onready var scene = get_node('CurrentScene')

var first_scene = preload('res://core/Start.tscn')



func get_current_scene():
	return scene.get_children()


func set_current_scene(scn):
	for scene in get_current_scene():
		scene.queue_free()
	var S = scn.instance()
	scene.add_child(S)
	if scn == first_scene:
		get_node('CurrentScene/Start/MOTD').set_text(MOTD.get_motd())





func _ready():
	config = Config.get_config(configPath)
	set_all_keys()
	
	if get_current_scene().empty():
		set_current_scene(first_scene)
			

func set_all_keys():
	for action in config.get_section_keys('Keys'):
		var code = get_keybinding(action)
		var control = Config.get_key_control(code)
		Config.set_action(action,control)


func is_using_joystick():
	var joy = config.get_value('Controls','mode')
	if joy == 1:
		return true
	return false

func get_joystick_data():
	var device = config.get_value('Controls','joy_device')
	var x = config.get_value('Controls','joy_x_axis')
	var y = config.get_value('Controls','joy_y_axis')
	return [device, x, y]

func get_keybinding(action):
	return config.get_value('Keys',action)

func get_button(action):
	return config.get_value('Buttons',action)

func set_screenres(mult):
	var size = get_tree().get_root().get_rect().size
	print(size)
	size *= mult
	OS.set_window_size(size)

func set_fullscreen(fullscreen):
	OS.set_window_fullscreen(fullscreen)

func set_glow(glow):
	var env = main.get_node('WorldEnvironment').get_environment()
	#set the Glow Enabled parameter
	env.fx_set_param(2,glow)

func set_volume(value=1.0):
	AudioServer.set_fx_global_volume_scale(value)


func Quit():
	get_tree().quit()

