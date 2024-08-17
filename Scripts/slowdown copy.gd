extends Area2D

@onready var timer = $Timer
@onready var berry = $AnimationPlayer

func _on_body_entered(body):
	berry.play("pickup")
	Engine.time_scale = 0.5
	timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0 
	
