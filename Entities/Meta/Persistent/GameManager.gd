extends Node

#Globals
var GUI_active : bool = false
var cutscene_playing : bool = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_end")):
		get_tree().quit()
