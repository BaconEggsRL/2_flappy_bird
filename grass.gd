extends StaticBody2D

var SPEED : float = 150.0

@onready var screen_size = DisplayServer.window_get_size()
@onready var START_X : float = 0.0
@onready var MIN_X : float = -screen_size.x

@onready var color_rect: ColorRect = $ColorRect



func _physics_process(delta: float) -> void:
	if !Global.is_game_over and !Global.is_game_paused:
		color_rect.position.x -= SPEED * delta
		if color_rect.position.x < MIN_X:
			color_rect.position.x = START_X
