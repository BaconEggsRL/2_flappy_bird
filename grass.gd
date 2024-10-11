extends StaticBody2D

@onready var screen_size = DisplayServer.window_get_size()
@onready var START_X : float = -20.0
@onready var MIN_X : float = -screen_size.x + 1

# @onready var color_rect: ColorRect = $ColorRect
@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	if !Global.is_game_over and !Global.is_game_paused:
		sprite.position.x -= Global.SCROLL_SPEED * delta
		if sprite.position.x <= MIN_X:
			sprite.position.x = START_X
