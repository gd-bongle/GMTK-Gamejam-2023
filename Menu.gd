extends Control



func _on_play_game_gui_input(event):
	#if inputEvent.type == inputEvent.type("pressed"):
	pass



func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")


func _on_play_2_pressed():
	get_tree().quit()
