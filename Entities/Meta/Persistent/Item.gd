class_name Item
#extends Node

enum ITEM_TYPE{
	heal,
	damage,
	key
}
enum TARGET_TYPE{
	ally,
	enemy,
	everyone,
}
enum TARGET_NUMBER{
	single,
	all,
}

#var itemName : String = ""
#var type : int = ITEM_TYPE.heal
#var target_type : int = TARGET_TYPE.ally
#var target_number : int = TARGET_NUMBER.single
#var value : int = -1
#var description : String = ""
#var image : Resource = null


class Cookie :
	var itemName : String = "Cookie"
	var type : int = ITEM_TYPE.heal
	var target_type : int = TARGET_TYPE.ally
	var target_number : int = TARGET_NUMBER.single
	var value : int = 10
	var description : String = "A Cookie. Eat it to recover 10 HP during battle."
	var image : String = "res://Sprites/Items/Item Icons/cookie item icon.png"
class Bomb :
	var itemName : String = "Bomb"
	var type : int = ITEM_TYPE.damage
	var target_type : int = TARGET_TYPE.enemy
	var target_number : int = TARGET_NUMBER.all
	var value : int = 20
	var description : String = "Throw it to the enemies in battle to inflict 20 damage."
	var image : String = "res://Sprites/Items/Item Icons/bomb item icon.png"
class Key :
	var itemName : String = "Key"
	var type : int = ITEM_TYPE.key
	var target_type : int = -1
	var target_number : int = -1
	var value : int = -1
	var description : String = "Who knows what it can open..."
	var image : String = "res://Sprites/Items/Item Icons/key item icon.png"
