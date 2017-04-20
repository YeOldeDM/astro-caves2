extends TabContainer

onready var upgrades = get_node('UP')


func set_upgrades(data):
	self.upgrades.set_upgrades(data)

func change_tab(tab):
	set_current_tab(tab)
	if get_child(tab).has_method('go'):
		get_child(tab).go()

func _ready():
	Globals.Stats = self
	set_process_input(true)
	change_tab(0)

func _input(event):
	#if event.type == InputEvent.ACTION:
	var tab = get_current_tab()
	if event.is_action_pressed("menu_right"):
		tab += 1
	if event.is_action_pressed("menu_left"):
		tab -= 1
	if tab >= get_tab_count(): tab = 0
	if tab < 0: tab = get_tab_count() - 1
	
	if tab != get_current_tab():
		change_tab(tab)



