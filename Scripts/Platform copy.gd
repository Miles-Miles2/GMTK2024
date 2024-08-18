extends AnimatableBody2D

var speed = 60
var direction = 1
var count = 0
var max_limit = 0
var min_limit = 0
@export var platSpeedMult = 1

func _ready():
	var max_lim = position.x + 100
	var min_lim = position.x - 100
	max_limit = max_lim
	min_limit = min_lim
	print(max_lim)
	print(min_lim)

func _physics_process(delta):
	if position.x > max_limit:
		direction *= -1
	if position.x < min_limit:
		direction *= -1
	if position.x <= max_limit || position.x >= min_limit:
		position.x += speed * delta * direction * platSpeedMult

		
	
