
extends Node

var score = 0

@onready var score_label = $Label

func add_point():
	score += 1
	print(score)
	if score == 1:
		score_label.text = "You collected " + str(score) + " coin!"
	else:
		score_label.text = "You collected " + str(score) + " coins!"
	
