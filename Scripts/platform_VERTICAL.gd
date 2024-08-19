extends AnimatableBody2D

@onready var platSFX = $AudioStreamPlayer2D

@export var speed = 60
var direction = 1
var count = 0
var max_limit = 0
var min_limit = 0

@export var y_min: float
@export var y_max: float

@export var platSpeedMult = 1
@export var velocity: Vector2

@onready var y_min_absolute = position.y + y_min
@onready var y_max_absolute = position.y + y_max
	
	

func _physics_process(delta):
	if position.y <= y_min_absolute:
		direction *= -1
		position.y = y_min_absolute
	if position.y >= y_max_absolute:
		direction *= -1
		position.y = y_max_absolute
		
	velocity = Vector2(0, speed * delta * direction * platSpeedMult)
	
	move_and_collide(velocity)

	if platSpeedMult == 1:
		platSFX.pitch_scale = 0.9
		platSFX.volume_db = -20
	elif platSpeedMult == 2:
		platSFX.pitch_scale = 2.0
		platSFX.volume_db = -25
	elif platSpeedMult == .5:
		platSFX.pitch_scale = 0.7
		platSFX.volume_db = -20
		
	
