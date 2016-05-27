
extends Node

func Shake(amp,falloff):
	get_node('currentScene/Game/World').start_shake(amp,falloff)


