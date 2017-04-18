extends Camera2D

var shake_amp = 0.0
var shake_falloff = 0.5

func apply_shake(amt=1.0):
	if shake_amp < amt:
		shake_amp = amt
	if shake_amp > 0.0:
		set_fixed_process(true)

func _fixed_process(delta):
	var x = (randf() * shake_amp)*0.05
	var y = (randf() * shake_amp)*0.05
	var sv = Vector2(1-x,1-y)
	set_zoom(sv)

	shake_amp *= shake_falloff
	if shake_amp < 0.01:
		shake_amp = 0
		set_zoom(Vector2(1,1))
		set_fixed_process(false)
	
