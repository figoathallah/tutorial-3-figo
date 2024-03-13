extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -600
export (int) var GRAVITY = 1200

const UP = Vector2(0, -1)
var velocity = Vector2()
var doubleJump = false
var isCrouched = false
const DOUBLETAP_DELAY = 15
var doubleTap = DOUBLETAP_DELAY
var last_key = 0 
var key_pressed_time = 0.0		

	
func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
		doubleJump = true
		$Jump.play()
	elif doubleJump and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
		doubleJump = false
		$Jump.play()
		
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		isCrouched = true
	else:
		isCrouched = false
		
	if Input.is_action_pressed('ui_right'):
		if doubleTap >= 0 and last_key == KEY_D or last_key == KEY_RIGHT:
			velocity.x += speed * 2
			$Dash.play()		
		elif isCrouched == true:
			velocity.x += speed / 2
		else:
			velocity.x += speed
	if Input.is_action_pressed('ui_left'):
		if doubleTap >= 0 and last_key == KEY_A or last_key == KEY_LEFT:
			velocity.x -= speed * 2
			$Dash.play()	
		elif isCrouched == true:
			velocity.x -= speed / 2
		else:
			velocity.x -= speed
	
	doubleTap -= 1
	if doubleTap < 0:
		last_key = 0
		doubleTap = DOUBLETAP_DELAY
		

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)

	if is_on_floor():
		doubleJump = false

func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			key_pressed_time = OS.get_ticks_msec() / 1000.0
		else:
			var current_time = OS.get_ticks_msec() / 1000.0
			var key_hold_duration = current_time - key_pressed_time
			if last_key == event.scancode and doubleTap >= 0 and key_hold_duration < DOUBLETAP_DELAY:
				last_key = 0
			else:
				last_key = event.scancode
			doubleTap = DOUBLETAP_DELAY
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	doubleTap -= delta
		
	if Input.is_action_pressed("ui_left") and is_on_floor():
		$AnimatedSprite.play("walk_right")
		if $Timer.time_left <= 0:
			$Footsteps.pitch_scale = rand_range(0.8, 1.2)
			$Footsteps.play()
			$Timer.start(0.2)
	elif Input.is_action_pressed("ui_right") and is_on_floor():
		$AnimatedSprite.play("walk_right")
		if $Timer.time_left <= 0:
			$Footsteps.pitch_scale = rand_range(0.8, 1.2)
			$Footsteps.play()
			$Timer.start(0.2)
	elif Input.is_action_pressed("ui_down") and is_on_floor():
		$AnimatedSprite.play("crouch")
		$Footsteps.stop()
	elif velocity.y < 0:
		$AnimatedSprite.play("jump")
	else:
		$AnimatedSprite.play("idle")
		$Footsteps.stop()
	
	if !is_on_floor():
		$Footsteps.stop()
		
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = true

