extends Menu

enum options{
	ITEMS,
	MAGIC,
	STATS,
	OPTIONS,
	ENUM_SIZE
}

onready var selectorNode : Node2D = $NinePatchRect/Selector
onready var selectorNode_initPosition : Vector2 = selectorNode.position
onready var labelsArray : Array = [
	$NinePatchRect/GridContainer/Label,
	$NinePatchRect/GridContainer/Label2,
	$NinePatchRect/GridContainer/Label3,
	$NinePatchRect/GridContainer/Label4
	]
onready var itemMenuScene : PackedScene = preload("res://GUI/ItemMenu.tscn")	


var selection : int = options.ITEMS
var space_between : int = 56

func _ready() -> void:
	parentMenuNode = self
	state = OPENING
	GameManager.GUI_active = true
	animationNode.play("Opening")

func _process(_delta: float) -> void:
	match state:
		OPENING:
			if animationNode.is_playing() == false:
				state = ACTIVE
			pass
		ACTIVE: 
			#_input
			pass
		INACTIVE:
			pass
		CLOSING:
			if animationNode.is_playing() == false:
				GameManager.GUI_active = false
				queue_free()
			pass
		

func _input(event: InputEvent) -> void:
	if state == ACTIVE:
		var selection_changed : bool = false
		
		#Manage Selection
		if event.is_action_pressed("ui_left", false): 
			selection -= 1
			selection_changed = true
		elif event.is_action_pressed("ui_right", false): 
			selection += 1
			selection_changed = true
		
		if selection_changed:
			selection = int(clamp(selection, 0, options.ENUM_SIZE - 1)) #added int to prevent debugger warning
		
			#Change selector coordinates
			var newPos : Vector2 = labelsArray[selection].rect_position - Vector2(1,0)
			selectorNode.position = newPos
			selectorNode.get_node("AnimatedSprite").frame = 0
		
		#Open new Menu
		if event.is_action_pressed("ui_accept"):
			var menuPackedScene : PackedScene
			match selection:
				options.ITEMS:
#					var instance : Node = itemMenuScene.instance()
#					get_parent().add_child(instance)
					menuPackedScene = itemMenuScene
				
				options.MAGIC:
					pass
					
				options.STATS:
					pass
				
				options.OPTIONS:
					pass
				
				_: menuPackedScene = null
			
			if menuPackedScene != null:
				open_menu(menuPackedScene)
		
		#Close Menu
		if event.is_action_pressed("menu") or event.is_action_pressed("ui_cancel"):
			animationNode.play_backwards("Opening")
			state = CLOSING
		
