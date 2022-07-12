extends KinematicBody2D

const GlobalEnums = preload("res://Entities/Meta/Persistent/GlobalEnums.gd")

onready var animatedSprite = $AnimatedSprite
onready var rootNode = get_tree().get_root()
onready var mapNode = get_node("/root/Map Handler").current_map
onready var cameraNode = get_node("/root/Map Handler/MainCamera")
onready var mainMenuScene = preload("res://GUI/MainMenu.tscn")

var walk_speed: float = 50
var moveX : float = 0
var moveY : float = 0
var facing_dir = GlobalEnums.Facing_dir.down


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
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

	#Commit movement
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	
	#Set facing_dir
	if (is_equal_approx(moveY, 0) == false):
		if (sign(moveY) == 1): 
			facing_dir = GlobalEnums.Facing_dir.down
		else: 
			facing_dir = GlobalEnums.Facing_dir.up
	elif (is_equal_approx(moveX, 0) == false):
		if (sign(moveX) == 1): 
			facing_dir = GlobalEnums.Facing_dir.right
		else: 
			facing_dir = GlobalEnums.Facing_dir.left

	
	#Set animation
	match facing_dir:
		GlobalEnums.Facing_dir.right:
			animatedSprite.play("Right")
			
		GlobalEnums.Facing_dir.up:
			animatedSprite.play("Up")
			
		GlobalEnums.Facing_dir.left:
			animatedSprite.play("Left")
			
		GlobalEnums.Facing_dir.down:
			animatedSprite.play("Down")
	
	#Stop animation if not moving
	if (is_equal_approx(moveX,0) and is_equal_approx(moveY,0)):
		animatedSprite.playing = false
		animatedSprite.frame = 0


func _input(event: InputEvent) -> void:
	if (GameManager.GUI_active == false and GameManager.cutscene_playing == false):
		#Create Menu
		if event.is_action_pressed("menu"):
			if cameraNode.has_node("MainMenu") == false:
				var instance = mainMenuScene.instance()
				cameraNode.add_child(instance)
	
