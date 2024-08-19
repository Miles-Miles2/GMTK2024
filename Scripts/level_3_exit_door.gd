extends Area2D

@onready var complete = $complete
@onready var timer = $Timer
@onready var player = $"../Player"

@export var nextScene: String

func _on_body_entered(body):
	player.set_physics_process(false)
	player.get_node("AnimatedSprite2D").play("jump")
	complete.play()
	timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file(nextScene)
