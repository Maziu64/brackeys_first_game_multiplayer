extends Node

var score = 0
@onready var lbl_score: Label = $LblScore

func add_point():
	score += 1
	lbl_score.text = "You collected " + str(score) + " coins"

func become_host():
	print("Become host pressed")
	MultiplayerManager.become_host()
	%MultiplayerHUD.hide()
func join_as_player_2():
	print("Join as player 2")
	MultiplayerManager.join_as_player_2()
	%MultiplayerHUD.hide()
