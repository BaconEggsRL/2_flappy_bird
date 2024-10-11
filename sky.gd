extends Sprite2D

@onready var screen_size = DisplayServer.window_get_size()
@onready var START_X : float = 357.0
@onready var MIN_X : float = -START_X + 1

var BG_SCROLL_SPEED = Global.SCROLL_SPEED / 2

func _ready() -> void:
	self.position.x = START_X
	
	
func _physics_process(delta: float) -> void:
	if !Global.is_game_over and !Global.is_game_paused:
		position.x -= BG_SCROLL_SPEED * delta
		if position.x <= MIN_X:
			position.x = START_X
