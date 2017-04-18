extends Area2D

func spawn():
	for node in get_children():
		if node.is_in_group('spawners'):
			print(node.get_name())
			node.spawn()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Room_body_enter( body ):
	if body == Game.player:
		for mob in get_tree().get_nodes_in_group('mobs'):
			mob.queue_free()
		Game.player.set_room(self)
		spawn()


func _on_Room_area_exit( area ):
	if area.get_parent().is_in_group('bullets'):
		area.get_parent().queue_free()



