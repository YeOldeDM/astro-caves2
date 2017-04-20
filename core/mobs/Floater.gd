extends KinematicBody2D


var life = 4 setget _set_life


onready var dir = get_random_direction()
var speed = 100

var pain_force = Vector2()

func get_random_direction():
	var x = rand_range(-1,1)
	var y = rand_range(-1,1)
	return Vector2(x,y).normalized()


# Pick a new random direction
func scoot():
	self.speed = 100
	self.dir = get_random_direction()
	set_fixed_process(true)


# Take damage
func take_damage(amt,origin=null):
	self.life -= amt
	if origin != null:
		var f = (get_global_pos() - origin.get_global_pos()).normalized()
		move(f*2)


func kill():
	remove_from_group('mobs')
	die()


func die():
	queue_free()
	

func _ready():
	add_to_group('mobs')
	set_fixed_process(true)


func _fixed_process(delta):
	# Move
	var force = dir*speed*delta
	var motion = move(force)
	# Bounce
	if is_colliding():
		var norm = get_collision_normal()
		motion = norm.reflect(motion)
		dir = norm.reflect(dir)
	move(motion)
	# Decrement speed
	speed *= 0.93
	# When real close to 0, start go idle
	if speed < 0.5:
		get_node('Idle').start()
		set_fixed_process(false)


func _set_life(what):
	life = what
	if life <= 0:
		kill()


func _on_Idle_timeout():
	# Pick a new random direction
	scoot()
