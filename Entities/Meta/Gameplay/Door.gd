class_name Door

extends Area2D

signal change_map(new_map, map_parameters)

const GlobalEnums = preload("res://Entities/Meta/Persistent/GlobalEnums.gd")

export (int, "right", "up", "left", "down") var required_facing_dir
export var closed : bool
export (String, FILE, "*.tscn") var target_map
export var map_parameters : Dictionary = {
	"spawn_player" : true,
	"season_changed" : false,
	"spawn_player_data" : {
		"spawner_name" : "SpawnerA",
		"facing_dir" : GlobalEnums.Facing_dir.down,
	},
}

onready var mapHandlerNode : Node = $"/root/Map Handler"
onready var mainCameraNode : Camera2D = $"/root/Map Handler/MainCamera"
#onready var playerNode : Node = mapHandlerNode.current_map.get_node_or_null("YSort/Character")
var playerNode : Node


func _ready() -> void:
	#Connect custom signal with Map Handler
	if !is_connected("change_map", mapHandlerNode, "start_map_transition"):
# warning-ignore:return_value_discarded
		connect("change_map", mapHandlerNode, "start_map_transition")


func _process(_delta: float) -> void:
	if (GameManager.GUI_active == false and GameManager.cutscene_playing == false):
		if is_instance_valid(playerNode):
			
			if overlaps_body(playerNode):
				if closed:
					if required_facing_dir == playerNode.facing_dir and Input.is_action_just_pressed("ui_accept"):
						emit_signal("change_map", target_map, map_parameters)
				else:
					emit_signal("change_map", target_map, map_parameters)
			
#			if overlaps_body(playerNode) and required_facing_dir == playerNode.facing_dir:
#				if closed:
#					if (Input.is_action_just_pressed("ui_accept")):
#						emit_signal("change_map", target_map, map_parameters)
#				else:
#					emit_signal("change_map", target_map, map_parameters)


func set_playerNode(_playerNode : Node) -> void:
	playerNode = _playerNode
