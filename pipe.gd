extends Area2D

signal hit_pipe
signal scored

var MIN_X : float = 0


func _physics_process(delta: float) -> void:
	if !Global.is_game_over and !Global.is_game_paused:
		self.position.x -= Global.SCROLL_SPEED * delta
		if self.position.x < MIN_X:
			queue_free()


func _on_body_entered(body: Node2D) -> void:
	if !Global.is_game_over and !Global.is_game_paused:
		if body.is_in_group("player"):
			Global.play_sound("falling")
			hit_pipe.emit()


func _on_score_area_body_entered(body: Node2D) -> void:
	if !Global.is_game_over and !Global.is_game_paused:
		if body.is_in_group("player"):
			scored.emit()
