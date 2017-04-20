extends Control

onready var upgrades = get_node('box')

func go():
	upgrades.get_child(0).grab_focus()

func set_upgrades(data):
	for key in data:
		if upgrades.has_node(key):
			upgrades.get_node(key).set_pressed(data[key])

func _ready():
	for box in upgrades.get_children():
		box.connect("toggled", self, "_on_Upgrades_checkbox_toggled", [box.get_name()])


func _on_Upgrades_checkbox_toggled(toggled, name):
	Globals.player.upgrades[name] = toggled
