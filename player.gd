extends CharacterBody2D

var up_rot = -25
var MIN_LERP_SPEED = 0.05
var MAX_LERP_SPEED = 1.0

@onready var game = get_parent()

signal hit_ground

var has_hit_ground : bool = false

@export var anim : AnimatedSprite2D


func _on_hit_ground() -> void:
	Global.play_sound("dead")
	has_hit_ground = true
	hit_ground.emit()


func jump() -> void:
	Global.play_sound("flap")
	set_rotation(deg_to_rad(up_rot))
	velocity.y = Global.JUMP_VEL


func rotate_player() -> void:
	# set_rotation(deg_to_rad(velocity.y * 0.05))
	# print(velocity.y)
	set_rotation(lerpf(rotation, PI/2, remap(clampf(velocity.y, 0, 450), 0, 450, 0, 1)))
	
	
func _physics_process(delta: float) -> void:

	# Don't do anything if the game is paused
	if !Global.is_game_paused:
		
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		# Rotate player when falling
			if self.velocity.y > 0:
				rotate_player()
		
		# Move and slide
		move_and_slide()
		# Get slide collisions
		if !has_hit_ground:
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				var collider = collision.get_collider()
				if collider.is_in_group("killzone"):
					print("I collided with ", collider.name)
					_on_hit_ground()
					return  # don't execute jump this frame

			# Check if game over
			if !Global.is_game_over:
				# Handle jump
				if Input.is_action_just_pressed("jump"):
					jump()
