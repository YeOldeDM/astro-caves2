
extends Panel

onready var lifebar = get_node('LifeBar')

func set_lifebar(value):
	lifebar.set_value(value)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


