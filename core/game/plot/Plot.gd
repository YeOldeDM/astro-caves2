extends Control

signal done()

onready var text = get_node('box/Text')
onready var char_timer = get_node('CharTimer')

const TICK_LENGTH = 0.11

var _txt = null setget _set_txt
var _chars = 200
var ticked = 0


func set_plot(text="There is no text."):
	self._txt = text
	start()


func start():
	ticked = 0
	char_timer.set_wait_time(TICK_LENGTH)
	char_timer.start()

func stop():
	char_timer.stop()
	emit_signal("done")

func _ready():
	Globals.Plot = self
	text.set_scroll_active(false)

func _tick():
	ticked += 1
	if ticked > _chars:
		stop()
	else:
		text.set_visible_characters(ticked)


func _set_txt(what):
	print(what)
	_txt = what
	text.clear()
	text.append_bbcode(_txt)
	_chars = text.get_text().length()
	prints('chars',_chars)


func _on_CharTimer_timeout():
	_tick()
