extends HBoxContainer

const NODES = [
				preload("res://interface/nodes/node_00.png"),
				preload("res://interface/nodes/node_01.png"),
				preload("res://interface/nodes/node_02.png"),
				preload("res://interface/nodes/node_03.png")
]

func juan_new_node():
	randomize()
	var t = TextureRect.new()
	var index = randi()%NODES.size()
	t.texture = NODES[index]
	add_child(t)
	if get_child_count() >= 5:
		for c in get_children():
			c.self_modulate = Color("5efca3")