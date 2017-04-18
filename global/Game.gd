extends Node

var Gv = Vector2(0,1)
var G = 0

var player

func get_gravity():
	var g = Gv
	g.y *= G
	return g

func set_gravity(what):
	self.G = what