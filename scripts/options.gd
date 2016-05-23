
extends TabContainer

onready var buttons = get_node('Base/box').get_children()
onready var game = get_node('/root/Game')


func _ready():
	for b in buttons:
		b.set_text(b.get_name())
		b.connect('pressed',self,'_on_base_Button_pressed',[b.get_name()])
	buttons[4].grab_focus()

func _on_Return():
	set_current_tab(0)
	buttons[4].grab_focus()
	
	
func _GoTo_Graphics():
	set_current_tab(1)
	get_node('Graphics/box/Back').grab_focus()
	
func _GoTo_Audio():
	set_current_tab(2)
	get_node('Audio/box/Back').grab_focus()

func _GoTo_Controls():
	set_current_tab(3)
	get_node('Controls/box/Back').grab_focus()

func _GoTo_Credits():
	set_current_tab(4)
	get_node('Credits/box/Back').grab_focus()

func _GoTo_KeyConfig():
	set_current_tab(5)
	get_node('KeyConfig/box/fly_up').grab_focus()
func _on_base_Button_pressed(button):
	print(button)
	if has_method("_GoTo_"+button):
		call("_GoTo_"+button)







func _on_pixel_size_option_item_selected( ID ):
	var fullscreen = false
	var size = get_tree().get_root().get_rect().size
	if ID == 4:
		fullscreen = true
	else:
		size *= ID+1

	OS.set_window_fullscreen(fullscreen)
	if !fullscreen:
		OS.set_window_size(size)



func _on_glow_toggled( pressed ):
	var env = game.get_node('WorldEnvironment').get_environment()
	#set the Glow Enabled parameter
	env.fx_set_param(2,pressed)


#KEY/BUTTON CONFIGURATION
func _on_Config_pressed():
	var mode = 'JoyConfig'
	if !game.using_joystick:
		mode = 'KeyConfig'
	_on_base_Button_pressed(mode)

		


func _on_SFX_toggled( pressed ):
	var vol = get_parent().get_node('volume').get_value()
	if !pressed:
		vol = 0
	_on_volume_value_changed(vol)


func _on_volume_value_changed( value ):
	if !get_parent().get_node('on').is_pressed():
		AudioServer.set_fx_global_volume_scale(value)


func _on_key_joy_item_selected( ID ):
	if ID == 0:		game.using_joystick = false
	elif ID == 1:	game.using_joystick = true
