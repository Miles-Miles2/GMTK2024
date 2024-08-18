extends Node

@onready var timer = $Timer
@onready var death = $deathSFX


func _on_body_entered(body):
	print("You died!")
	death.play()
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	



func _on_timer_timeout():
	Engine.time_scale = 1.0 
	get_tree().reload_current_scene()




func _on_ground_check_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
