extends Node2D

var screen_size = DisplayServer.window_get_size()
var grass_height = 100
var pipe_range = 200

const pipe_scene = preload("res://pipe.tscn")

@onready var pipes = $pipes
@onready var pipe_timer = $PipeTimer

@onready var wait_time = 1.75
@onready var pipe_speed = 175

@export var grass : Area2D
@export var player : CharacterBody2D
@export var score_label : Label

@onready var start_canvas: CanvasLayer = $Start
@onready var gameover_canvas: CanvasLayer = $GameOver


var score = -1



# back to main
func _on_button_pressed() -> void:
	Global.to_main()



# don't use process because it uses the global input state and will carry over from scenes.
func _input(_event: InputEvent) -> void:
	if start_canvas.visible:
		if Input.is_action_just_released("start_game"):
			start_game()
	
	
func _ready() -> void:
	Global.is_game_over = false
	Global.is_game_paused = true
		
	# Set the current scene
	Global.current_scene = self
	pipe_timer.wait_time = 2.0
	# grass.hit.connect(player_hit)
	player.hit_ground.connect(player_hit_ground)
	
	# ensure canvas visibility is set properly
	start_canvas.show()
	gameover_canvas.hide()
	


func start_game():
	Global.is_game_over = false
	Global.is_game_paused = false
	
	generate_pipe()
	pipe_timer.start()
	
	player.jump()
	
	start_canvas.hide()


func _on_pipe_timer_timeout() -> void:
	score += 1
	score_label.text = str(score)
	if score > 0:
		Global.play_sound("point")
	generate_pipe()
	
	
func generate_pipe() -> void:
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x
	pipe.position.y = (screen_size.y - grass_height) / 2 + randi_range(-pipe_range, pipe_range)
	pipe.hit_pipe.connect(player_hit_pipe)
	pipe.SPEED = pipe_speed
	pipes.add_child(pipe)


# on player hit pipe
func player_hit_pipe() -> void:
	gameover()


# on player hit ground
func player_hit_ground() -> void:
	if !Global.is_game_over:
		gameover()
	gameover_canvas.show()
	
	

func gameover() -> void:
	gameover_canvas.new_best.hide()
	Global.is_game_over = true
	Global.is_game_paused = false
	
	
	# Global.play_sound("dead")
	pipe_timer.stop()
	
	if score < 0:
		score = 0
	
	gameover_canvas.score_label.text = "SCORE: %s" % str(score)
	
	if score > Global.save_data.high_score:
		gameover_canvas.new_best.show()
		Global.save_data.high_score = score
		Global.save_data.save()
	
	gameover_canvas.best_label.text = "BEST: %s" % Global.save_data.high_score
	
	# gameover_canvas.show()
