extends CharacterBody2D

@onready var animated_sprite2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $jumpSound
@onready var death_sound: AudioStreamPlayer2D = $deathSound

const SPEED = 300.0
const JUMP_VELOCITY = -700.0
var alive = true

var gravity_direction = 1

func _physics_process(delta: float) -> void:
	
	if !alive:
		return
	
	if Input.is_action_just_pressed("flip"):
		gravity_direction *=-1
		up_direction = Vector2(0, -gravity_direction)
		animated_sprite2d.flip_v = (gravity_direction == -1)
		
	
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite2d.animation = "Run"
	else:
		animated_sprite2d.animation = "Idle"
	
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_direction
		animated_sprite2d.animation = "Jump"
		


	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * gravity_direction
		jump_sound.play()
		

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1:
		animated_sprite2d.flip_h = false
	elif direction == -1:
		animated_sprite2d.flip_h = true
		
func die() -> void:
	death_sound.play()
	animated_sprite2d.animation = "Die"
	alive = false
