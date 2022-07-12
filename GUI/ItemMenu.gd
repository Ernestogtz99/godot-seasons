extends Menu


onready var inventoryNode : Node = get_node("/root/Map Handler/Inventory")
onready var inventory : Array = inventoryNode.playerInventory
onready var itemLabels : Array = [
	$ItemsDisplay/GridContainer/Label,
	$ItemsDisplay/GridContainer/Label2,
	$ItemsDisplay/GridContainer/Label3,
	$ItemsDisplay/GridContainer/Label4,
	$ItemsDisplay/GridContainer/Label5,
	$ItemsDisplay/GridContainer/Label6,
	$ItemsDisplay/GridContainer/Label7,
	$ItemsDisplay/GridContainer/Label8,
]


func _ready() -> void:
	
	#Populate Labels' text
	var n_items := inventory.size()
	var i := 1
	for label in itemLabels:
		if i > n_items:
			label.text = ""
		else:
			label.text = inventory[i - 1].itemName
		i += 1


func _input(event: InputEvent) -> void:
	
	#Close Menu
	if event.is_action_pressed("ui_cancel"):
		get_tree().set_input_as_handled()
		close_menu(parentMenuNode)
		
