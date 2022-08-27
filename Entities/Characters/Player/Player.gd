extends KinematicBody2D

signal change_map(new_map, map_parameters)

const GlobalEnums = preload("res://Entities/Meta/Persistent/GlobalEnums.gd")

enum Seasons {
	spring,
	summer,
	fall,
	winter
}

onready var animatedSprite = $AnimatedSprite
onready var rootNode = get_tree().get_root()
onready var mapHandlerNode = get_node("/root/Map Handler")
onready var mapNode = mapHandlerNode.current_map
onready var cameraNode = get_node("/root/Map Handler/MainCamera")

var walk_speed: float = 50
var moveX : float = 0
var moveY : float = 0
var facing_dir = GlobalEnums.Facing_dir.down


func _ready() -> void:
	if !is_connected("change_map", mapHandlerNode, "start_map_transition"):
# warning-ignore:return_value_discarded
		connect("change_map", mapHandlerNode, "start_map_transition")
	pass


func _physics_process(_delta: float) -> void:
	var input_left:= int(Input.is_action_pressed("ui_left"))
	var input_right:= int(Input.is_action_pressed("ui_right"))
	var input_up:= int(Input.is_action_pressed("ui_up"))
	var input_down:= int(Input.is_action_pressed("ui_down"))
	
	if (GameManager.GUI_active == true or GameManager.cutscene_playing == true):
		moveX = 0
		moveY = 0
	else:
		moveX = (input_right - input_left) * walk_speed
		moveY = (input_down - input_up) * walk_speed
	
	var velocity : Vector2 = Vector2(moveX,moveY)

	#COMMIT MOVEMENT
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	
	#SET facing_dir
	#If move is diagonal
	if (is_equal_approx(moveY, 0) == false and is_equal_approx(moveX, 0) == false):
		if (sign(moveY) == 1 and sign(moveX) == 1):
			facing_dir = GlobalEnums.Facing_dir.rightdown
		elif(sign(moveY) == -1 and sign(moveX) == 1):
			facing_dir = GlobalEnums.Facing_dir.rightup
		elif(sign(moveY) == 1 and sign(moveX) == -1):
			facing_dir = GlobalEnums.Facing_dir.leftdown
		elif(sign(moveY) == -1 and sign(moveX) == -1):
			facing_dir = GlobalEnums.Facing_dir.leftup
	
	elif (is_equal_approx(moveY, 0) == false):
		if (sign(moveY) == 1): 
			facing_dir = GlobalEnums.Facing_dir.down
		else: 
			facing_dir = GlobalEnums.Facing_dir.up
	elif (is_equal_approx(moveX, 0) == false):
		if (sign(moveX) == 1): 
			facing_dir = GlobalEnums.Facing_dir.right
		else: 
			facing_dir = GlobalEnums.Facing_dir.left

	
	#SET ANIMATION
	match facing_dir:
		GlobalEnums.Facing_dir.right:
			animatedSprite.play("Right")
			
		GlobalEnums.Facing_dir.up:
			animatedSprite.play("Up")
			
		GlobalEnums.Facing_dir.left:
			animatedSprite.play("Left")
			
		GlobalEnums.Facing_dir.down:
			animatedSprite.play("Down")
		
		GlobalEnums.Facing_dir.rightdown:
			animatedSprite.play("RightDown")
		
		GlobalEnums.Facing_dir.rightup:
			animatedSprite.play("RightUp")
			
		GlobalEnums.Facing_dir.leftdown:
			animatedSprite.play("LeftDown")
			
		GlobalEnums.Facing_dir.leftup:
			animatedSprite.play("LeftUp")
	
	#Stop animation if not moving
	if (is_equal_approx(moveX,0) and is_equal_approx(moveY,0)):
		animatedSprite.playing = false
		animatedSprite.frame = 0


func _input(event: InputEvent) -> void:
	if (GameManager.GUI_active == false and GameManager.cutscene_playing == false):
		
		#CHANGE SEASON (MAP)
		if (event.is_action_pressed("change_season")):
			var targetMap
			
			match (mapNode.name):
				"Spring": targetMap = "res://Maps/Summer.tscn"
				"Summer": targetMap = "res://Maps/Fall.tscn"
				"Fall": targetMap = "res://Maps/Winter.tscn"
				"Winter": targetMap = "res://Maps/Spring.tscn"
				_: targetMap = "res://Maps/Summer.tscn"
			
			emit_signal("change_map", targetMap, {
									"spawn_player" : true,
									"season_changed" : true,
									"spawn_player_data" : {
										"spawner_name" : "",
										"facing_dir" : facing_dir,
										"new_pos" : position,
										}
									})
