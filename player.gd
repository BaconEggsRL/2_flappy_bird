extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var game = get_parent()

signal hit_ground

var has_hit_ground : bool = false


func _on_hit_ground() -> void:
	Global.play_sound("dead")
	has_hit_ground = true
	hit_ground.emit()


func jump() -> void:
	Global.play_sound("flap")
	velocity.y = JUMP_VELOCITY
	
	
	
func _physics_process(delta: float) -> void:

	# Add the gravity.
	if !Global.is_game_paused:
		if not is_on_floor():
			velocity += get_gravity() * delta


	if !Global.is_game_over and !Global.is_game_paused:

		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			jump()

	
	if !has_hit_ground: 
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider.is_in_group("killzone"):
				print("I collided with ", collider.name)
				_on_hit_ground()
				
				
	move_and_slide()
