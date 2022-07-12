#Camera needs to be the last node in the Map/Scene tree
#So gui nodes come always on top of everything being drawn

extends Camera2D

var mapNode : Node 
var ySortNode : YSort
var target = -1


func _ready() -> void:
	mapNode = $"/root/Map Handler".current_map
	ySortNode = mapNode.get_node("YSort")
	
	if ySortNode.has_node("Character"):
		target = ySortNode.get_node("Character")
	else: target = -1


func _process(_delta: float) -> void:
	if is_instance_valid(target) :
		position = target.position

func map_changed() -> void:
	#Set a target
	_ready()
	
	#Move Main Camera to the bottom of the node list of Map Handler
	get_parent().move_child(self, mapNode.get_index() + 1)
