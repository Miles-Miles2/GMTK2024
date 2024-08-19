extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var jumpSFX = $jumpSFX

var addVelocityDebounce: int = 0

@export var platformSpeedMultiplyer = 1
@export var enemySpeedMultiplyer = 1
#@onready var animation_player = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	addVelocityDebounce = max(0, addVelocityDebounce - 1)
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumpSFX.play()
		velocity.y += JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
		
	if is_on_floor():
		if direction == 0:
			pass
			animated_sprite.play("idle")	
		else:
			pass
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	
	
	if direction:
		if is_on_floor():
			velocity.x = direction * SPEED
		else:
			if abs(velocity.x + (direction * SPEED)*0.2) < SPEED:
				velocity.x += (direction * SPEED)*0.2
			elif abs(velocity.x	 + (direction * SPEED)*0.2) < abs(velocity.x):
				velocity.x += (direction * SPEED)*0.2
		
	else:
		if is_on_floor():
			velocity.x = 0

	move_and_slide()
	
	#handle speedup/slowdonw
	var changeSpeed: bool = false
	
	if Input.is_action_just_pressed("speedup_enemy"):
		enemySpeedMultiplyer = 2.5
		changeSpeed = true
	elif Input.is_action_just_pressed("slowdown_enemy"):
		enemySpeedMultiplyer = 0.35
		changeSpeed = true
	
	if Input.is_action_just_released("speedup_enemy"):
		enemySpeedMultiplyer = 1
		changeSpeed = true
	elif Input.is_action_just_released("slowdown_enemy"):
		enemySpeedMultiplyer = 1
		changeSpeed = true
	
	if changeSpeed:
		for node in get_tree().get_nodes_in_group("enemy"):
			node.speedMult = enemySpeedMultiplyer
		
	
	if Input.is_action_just_pressed("speed_plat"):
		platformSpeedMultiplyer = 2
		changeSpeed = true
	elif Input.is_action_just_pressed("slow_plat"):
		platformSpeedMultiplyer = 0.5
		changeSpeed = true
	
	if Input.is_action_just_released("speed_plat"):
		platformSpeedMultiplyer = 1
		changeSpeed = true
	elif Input.is_action_just_released("slow_plat"):
		platformSpeedMultiplyer = 1
		changeSpeed = true
	
	if changeSpeed:
		for node in get_tree().get_nodes_in_group("Platforms"):
			node.platSpeedMult = platformSpeedMultiplyer



func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Platforms")) and addVelocityDebounce <= 0:
		addVelocityDebounce += 10
		#print("adding velocity: " + str(body.velocity))
		velocity += body.velocity
