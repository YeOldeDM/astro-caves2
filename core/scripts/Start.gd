
extends Container

onready var main = get_node('/root/Main')

var options = preload('res://core/Options.tscn')
var play = preload('res://core/Game.tscn')


func _ready():
	get_node('Buttons/Play').grab_focus()


func _on_Play_pressed():
	main.set_current_scene(play)


func _on_Options_pressed():
	main.set_current_scene(options)


func _on_Quit_pressed():
	get_tree().quit()
