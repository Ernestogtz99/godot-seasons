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
	state = OPENING
	GameManager.GUI_active = true
	animationNode.play("Opening")


func _input(event: InputEvent) -> void:
	if state == ACTIVE:
		
		var selection_changed : bool = false
		
		#MANAGE SELECTION
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
		
		
		#OPEN NEW MENU
		if event.is_action_pressed("ui_accept"):
			var menuPackedScene : PackedScene
			match selection:
				options.ITEMS:
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
		
		
		#CLOSE MENU
		if event.is_action_pressed("menu") or event.is_action_pressed("ui_cancel"):
			play_closing_animation()
		
		get_tree().set_input_as_handled()



func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	handle_finished_animation()
