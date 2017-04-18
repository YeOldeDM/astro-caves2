extends Particles2D

onready var timer = get_node('Timer')

func _ready():
	set_emitting(true)
	timer.set_wait_time(get_emit_timeout())
	timer.start()



func _on_Timer_timeout():
	queue_free()
