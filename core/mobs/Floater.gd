extends KinematicBody2D

var life = 1 setget _set_life

onready var dir = get_random_direction()
var speed = 100

func get_random_direction():
	var x = rand_range(-1,1)
	var y = rand_range(-1,1)
	return Vector2(x,y).normalized()

func scoot():
	self.speed = 100
	self.dir = get_random_direction()
	set_fixed_process(true)

func take_damage(amt):
	self.life -= amt

func kill():
	die()

func die():
	queue_free()
	

func _ready():
	add_to_group('mobs')
	set_fixed_process(true)

func _fixed_process(delta):
	var force = dir*speed*delta
	if is_colliding():
		var n = get_collision_normal()
		dir = dir.reflect(n)
	move(force)
	speed *= 0.9
	if speed < 1:
		get_node('Idle').start()
		set_fixed_process(false)

func _set_life(what):
	life = what
	if life <= 0:
		kill()

func _on_Idle_timeout():
	print('tick')
	scoot()
