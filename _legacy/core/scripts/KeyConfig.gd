
extends GridContainer

onready var config = get_node('/root/Main').config

onready var keyprompt = get_node('../../../assign_key')

func _ready():
	for I in get_children():
		if I extends Button:
			I.connect("pressed",self,"_on_prompt_key_assign",[I.get_name()])
			var code = config.get_value('Keys', I.get_name())
			print(code)
			var txt = OS.get_scancode_string(99)
			I.set_text(txt)

func _on_prompt_key_assign( action ):
	keyprompt.set_meta('action',action)
	keyprompt.set_meta('control',null)
	set_process_input(true)
	keyprompt.set_pos(Vector2(16,16))
	keyprompt.popup()



func _on_assign_key_input_event( ev ):
	var code = ev.scancode
	var name = OS.get_scancode_string(code)
	print(name)
	keyprompt.set_text(name)
	keyprompt.set_meta('control',Config.get_key_control(code))


func _on_assign_key_confirmed():
	var action = null
	var control = null
	if keyprompt.has_meta('action'):
		action = keyprompt.get_meta('action')
		if keyprompt.has_meta('control'):
			control = keyprompt.get_meta('control')
	
	if action != null && control != null:
		Config.set_action(action,control)
		config.set_value('Keys',action,control.scancode)
		config.save(get_node('/root/Main').configPath)
		var name = OS.get_scancode_string(control.scancode)
		get_node(action).set_text(name.capitalize())
		keyprompt.hide()


func _input( ev ):
	if ev.type == InputEvent.KEY:
		_on_assign_key_input_event(ev)

func _on_assign_key_popup_hide():
	set_process_input(false)
