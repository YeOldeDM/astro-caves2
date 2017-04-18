extends Position2D
tool

export(String, FILE, GLOBAL, "*.tscn") var spawn_path

func spawn():
	var obj = load(self.spawn_path).instance()
	if !obj: return
	get_parent().add_child(obj)
	obj.set_pos(get_pos())

func _ready():
	add_to_group('spawners')
