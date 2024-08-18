extends Node2D

@onready var ray_cast_right = $enemyBody2D/RayCastRight
@onready var ray_cast_left = $enemyBody2D/RayCastLeft
@onready var slime = $enemyBody2D/AnimatedSprite2D
@onready var body = $enemyBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#signal animation_done


var SPEED = 4000

@export var speedMult: float = 1


@onready var timer = $Timer

var start_move = false
var direction = 1

func _ready():
	timer.start()
	#slime.play("idle")
	
func _on_timer_timeout():
	#slime.play("idle")
	start_move = true
	
func _process(delta):
	
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
	
	if ray_cast_right.is_colliding():
		direction = -1
		slime.flip_h = true
		
		
	if ray_cast_left.is_colliding():
		direction = 1
		slime.flip_h = false
		
	if start_move:

		body.velocity.x = (SPEED * speedMult * delta * direction)

	body.move_and_slide()


func _on_ground_check_body_exited(body: Node2D) -> void:
	if (body.is_in_group("ground")) and speedMult <= 1:
		direction *= -1
