extends Node

signal map_has_changed
signal playerNode_has_changed(playerNode)

enum {
	FADE_IN,
	FADE_OUT,
	INACTIVE
}

const GlobalEnums = preload("res://Entities/Meta/Persistent/GlobalEnums.gd")

onready var mainCameraNode : Camera2D = $MainCamera
onready var roomTransitionNode : AnimationPlayer = mainCameraNode.get_node("Room Transition")
onready var playerPackedScene = preload("res://Entities/Character/Character.tscn")

var map_parameters : Dictionary = {}
var current_map : Node2D
var target_map : String 	#Recieved as a path
var state : int = INACTIVE


func _enter_tree() -> void:
	#DEBUG
	current_map = get_node("Map 1")


func _ready() -> void:
	
	#Create player for the first time
	var instance = playerPackedScene.instance()
	current_map.get_node("YSort").add_child(instance)
	instance.position = Vector2(430,113)
	
# warning-ignore:return_value_discarded
	connect("map_has_changed", mainCameraNode, "map_changed")
	
	#Connect all instances that refer to players node
	_connect_refPlayer_signal()
	emit_signal("playerNode_has_changed", instance)
	
	#Set playerNode variables of door and cameras 
	mainCameraNode._ready()


func _process(_delta: float) -> void:
	if state != INACTIVE:
		match state:
			FADE_IN:
				if roomTransitionNode.is_playing() == false:
					_change_map()
					state = FADE_OUT
					roomTransitionNode.play("fade_out")
					
			FADE_OUT:
				if roomTransitionNode.is_playing() == false:
					GameManager.cutscene_playing = false
					state = INACTIVE


func start_map_transition(_target_map : String, _map_parameters : Dictionary) -> void:
	map_parameters = _map_parameters
	GameManager.cutscene_playing = true
	target_map = _target_map
	state = FADE_IN
	roomTransitionNode.play("fade_in")
	pass


func _change_map() -> void:
	var new_map_packedScene := load(target_map)
	var new_mapNode = new_map_packedScene.instance()
	
	current_map.queue_free()
	current_map = new_mapNode
	add_child(new_mapNode)
	
	_connect_refPlayer_signal()
	_load_map_parameters()
	
	emit_signal("map_has_changed")
	target_map = ""


func _load_map_parameters() -> void:
	#Spawn Player
	if map_parameters.spawn_player :
		var spawner = current_map.get_node(map_parameters.spawn_player_data.spawner_name)
		var player := _create_instance_at_pos(playerPackedScene, spawner.position)
		player.facing_dir = map_parameters.spawn_player_data.facing_dir
		
		emit_signal("playerNode_has_changed", player)



func _create_instance_at_pos(packedScene : PackedScene, position : Vector2) -> Node:
	var ySortNode : YSort = current_map.get_node("YSort")
	var instance = packedScene.instance()
	ySortNode.add_child(instance)
	instance.position = position

	return instance


func _connect_refPlayer_signal() -> void:
	#Used to connect the signal that emits when playerNode reference changes
	
	var nodes = get_tree().get_nodes_in_group("Refers_Player_Node")
	for node in nodes:
		node._ready()
		if !is_connected("playerNode_has_changed", node, "set_playerNode"):
# warning-ignore:return_value_discarded
			connect("playerNode_has_changed", node, "set_playerNode")
