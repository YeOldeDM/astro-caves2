extends KinematicBody2D

var origin	# who shot this bullet
var dir		# dir/speed vector

var damage = 1

func fire(origin, pos, direction):
	self.origin = origin
	self.dir = direction
	set_pos(pos)
	set_fixed_process(true)

func die():
	var blam = load('res://core/bullets/LaserBlam.tscn').instance()
	get_parent().add_child(blam)
	var x = sign(dir.x)
	if x == 0: x = 1
	blam.set_scale(Vector2(x,1))
	blam.set_global_pos(get_global_pos())
	queue_free()

func _fixed_process(delta):
	move(self.dir*delta)
	var s = get_node('Beam').get_scale()
	s.x += 0.2
	get_node('Beam').set_scale(s)

func _ready():
	add_to_group('bullets')


func _on_Collder_body_enter( body ):
	if body != self.origin:
		if body.has_method('take_damage'):
			body.take_damage(self.damage)
		die()
