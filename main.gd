extends Node2D


func _ready() -> void:
	# Set the current scene
	Global.current_scene = self
	
	
func _on_start_button_pressed() -> void:
	Global.play_sound("button")
	Global.to_game()


func _on_score_button_pressed() -> void:
	Global.play_sound("button")
	print("score")
