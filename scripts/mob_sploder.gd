
extends Node2D

func _ready():
	var game = get_node('/root/Main/CurrentScene').get_child(0)
	game.Shake(4,20)
	

func _on_AnimationPlayer_finished():
	queue_free()
