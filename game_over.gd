extends CanvasLayer


@export var score_label : Label
@export var best_label : Label
@export var new_best : Label


func _on_ok_btn_pressed() -> void:
	Global.to_game()
