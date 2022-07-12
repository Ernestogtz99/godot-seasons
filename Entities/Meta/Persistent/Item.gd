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

#class Cookie:
#	extends Item
#	func _init() -> void:
#		itemName = "Cookie"
#		type = ITEM_TYPE.heal
#		target_type = TARGET_TYPE.ally
#		target_number = TARGET_NUMBER.single
#		value = 10
#		description = "A Cookie"
#		image = null
#
#const Cookie = {
#	"name" : "Cookie",
#	"type" : ITEM_TYPE.heal,
#	"target_type" : TARGET_TYPE.ally,
#	"target_number" : TARGET_NUMBER.single,
#	"value" : 10,
#	"description" : "A Cookie",
#	"image" : "",
#}
#const Bomb = {
#	"name" : "Bomb",
#	"type" : ITEM_TYPE.damage,
#	"target_type" : TARGET_TYPE.enemy,
#	"target_number" : TARGET_NUMBER.all,
#	"value" : 20,
#	"description" : "A Bomb",
#	"image" : "",
#}
#const Key = {
#	"name" : "Key",
#	"type" : ITEM_TYPE.key,
#	"target_type" : -1,
#	"target_number" : -1,
#	"value" : -1,
#	"description" : "A Key",
#	"image" : "",
#}

class Cookie :
	var itemName : String = "Cookie"
	var type : int = ITEM_TYPE.heal
	var target_type : int = TARGET_TYPE.ally
	var target_number : int = TARGET_NUMBER.single
	var value : int = 10
	var description : String = "A Cookie"
	var image : Resource = null
class Bomb :
	var itemName : String = "Bomb"
	var type : int = ITEM_TYPE.damage
	var target_type : int = TARGET_TYPE.enemy
	var target_number : int = TARGET_NUMBER.all
	var value : int = 20
	var description : String = "A Bomb"
	var image : Resource = null
class Key :
	var itemName : String = "Key"
	var type : int = ITEM_TYPE.key
	var target_type : int = -1
	var target_number : int = -1
	var value : int = -1
	var description : String = "A Key"
	var image : Resource = null
