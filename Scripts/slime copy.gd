extends Node2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var slime = $AnimatedSprite2D

signal animation_done


var SPEED = 60

@onready var timer = $Timer

var start_move = false
var direction = 1

func _ready():
	timer.start()
	slime.play("spawn")
	
func _on_timer_timeout():
	slime.play("idle")
	start_move = true
	
func _process(delta):
	
	if ray_cast_right.is_colliding():
		direction = -1
		slime.flip_h = true
		
		
	if ray_cast_left.is_colliding():
		direction = 1
		slime.flip_h = false
		
	if start_move:
		position.x += SPEED * delta * direction
