extends Node

const Item = preload("res://Entities/Meta/Persistent/Item.gd")

var playerInventory : Array = [
	Item.Cookie.new(),
	Item.Bomb.new(),
	Item.Key.new(),
	Item.Cookie.new(),
	Item.Bomb.new(),
	Item.Key.new(),
	Item.Cookie.new(),
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerInventory[0].value = 10000000
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
