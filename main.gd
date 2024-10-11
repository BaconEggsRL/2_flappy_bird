extends Node2D


func _ready() -> void:
	# Set the current scene
	Global.current_scene = self
	
	
func _on_button_pressed() -> void:
	Global.to_game()
