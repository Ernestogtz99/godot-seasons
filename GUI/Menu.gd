class_name Menu
extends Control

enum{
	OPENING,
	ACTIVE,
	INACTIVE,
	CLOSING,
}

var state : int
var parentMenuNode : Node 

onready var activeKeys : Array = [true]
onready var animationNode : AnimationPlayer = get_node_or_null("AnimationPlayer")



func open_menu(_packedScene : PackedScene) -> void:
	var instance : Node = _packedScene.instance()
	get_parent().add_child(instance)
	#get_parent().move_child(instance, self.get_index())
	
	activeKeys[0] = false
	state = INACTIVE
	
	instance.activeKeys[0] = true
	instance.parentMenuNode = self
	instance.animationNode.play("Opening")
	instance.state = OPENING


func close_menu(_parentMenuNode) -> void:
	_parentMenuNode.activeKeys[0] = true
	_parentMenuNode.state = ACTIVE
	
	queue_free()

func handle_finished_animation() -> void:
	match state:
		OPENING:
			state = ACTIVE
			pass
		
		CLOSING:
			if name == "MainMenu":
				GameManager.GUI_active = false
				queue_free()
			else:
				close_menu(parentMenuNode)
			

func play_closing_animation() -> void:
	if animationNode.has_animation("Closing"):
		animationNode.play("Closing")
	else :
		animationNode.play_backwards("Opening")
		
	state = CLOSING
	
