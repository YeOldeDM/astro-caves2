
extends Control

var DEFAULT = {
	'Graphics':	{
		'fullscreen':	false,
		'zoom':		4,
		'bloom':	true,
		'tint':		0},
	'Audio':	{
		'sfx_on':	true,
		'volume':	1.0},
	'Controls':	{
		'mode':	0,
		'joy_device':	0,
		'joy_x_axis':	0,
		'joy_y_axis':	1},
	'Keys':		{
		'back':			KEY_ESCAPE,
		'move_up':		KEY_W,
		'move_down':	KEY_S,
		'move_left':	KEY_A,
		'move_right':	KEY_D,
		
		'hold_direction':	KEY_SHIFT,
		'fire_laser':		KEY_SLASH,
		'fire_missile':		KEY_PERIOD,
		},
	'Buttons':	{
		'back':				11,
		'hold_direction':	6,
		'fire_laser':		0,
		'fire_missile':		2,
		},
	}



func get_config(path):
	var settings = ConfigFile.new()
	if settings.load(path) == OK:
		settings.load(path)
	else:
		settings = _make_default_config()
		settings.save(path)
	return settings

	


func get_key_control(code):
	var con = InputEvent()
	con.type = InputEvent.KEY
	con.scancode = code
	return con

func set_action(action,control):
	if InputMap.has_action(action):
		InputMap.erase_action(action)
	InputMap.add_action(action)
	InputMap.action_add_event(action,control)


func _make_default_config():
	var settings = ConfigFile.new()
	for key in DEFAULT:
		var section = key
		for S in DEFAULT[key]:
			settings.set_value(section,S,DEFAULT[key][S])
	return settings
	