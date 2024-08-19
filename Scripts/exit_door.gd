extends Area2D
@onready var complete = $complete
@onready var timer = $Timer
@onready var player = "test"

@export var nextScene: String

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]


func _on_body_entered(body):
	print("entered door")
	if body.is_in_group("player"):
		player.set_physics_process(false)
		player.get_node("AnimatedSprite2D").play("jump")
		complete.play()
		timer.start()
	
func _on_timer_timeout():
	get_tree().change_scene_to_file(nextScene)
