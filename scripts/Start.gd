
extends Container

onready var game = get_node('/root/Game')

var options = preload('res://options.tscn')
var play = preload('res://main.tscn')


func _ready():
	get_node('Buttons/Play').grab_focus()


func _on_Play_pressed():
	game.set_scene(play)


func _on_Options_pressed():
	game.set_scene(options)


func _on_Quit_pressed():
	get_tree().quit()
