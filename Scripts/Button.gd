extends Button

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var timer = $Timer

func _on_pressed():
	timer.start()
	audio_stream_player_2d.play()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
