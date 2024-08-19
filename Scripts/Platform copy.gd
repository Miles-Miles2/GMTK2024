extends AnimatableBody2D

@onready var platSFX = $AudioStreamPlayer2D

var speed = 60
var direction = -1
var count = 0
var max_limit = 0
var min_limit = 0
@export var platSpeedMult = 1
@export var velocity: Vector2

@export var x_min: float
@export var x_max: float

var delay = 0


func _ready():
	var max_lim = position.x + x_max
	var min_lim = position.x + x_min
	max_limit = max_lim
	min_limit = min_lim
	print(max_lim)
	print(min_lim)

func _physics_process(delta):
	if delay < 0.3:
		delay += delta
	else:
		if position.x > max_limit:
			direction *= -1
		if position.x < min_limit:
			direction *= -1
			
		velocity = Vector2(speed * delta * direction * platSpeedMult, 0)
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
		
	
