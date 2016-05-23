
extends GridContainer

var tile_obj = preload('res://resources/ui/minimap_tile.tscn')

func _ready():
	var col = int(get_rect().size.width / 5)
	set_columns(col)
	
	var row = int(get_rect().size.height / 3)
	
	printt(col,row)
	for i in range(col*row):
		var T = tile_obj.instance()
		add_child(T)
		T.get_node('Sprite').set_frame(rand_range(0,15))
	
func _funk():
	for c in get_children():
		c.get_node('Sprite').set_frame(rand_range(0,15))
	




func _on_Timer_timeout():
	_funk()
