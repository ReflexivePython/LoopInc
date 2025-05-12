extends Node

var goal = 0

func reset_score():
	goal = 0

func change_score(value : int):
	goal += value
