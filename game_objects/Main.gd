extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const LEVEL := preload("res://game_objects/Level.tscn")

var level
# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	$HUD.get_node("ScoreLabel").text = \
#	str(level.get_node("Player").score)

func _on_Menu_playButtonPressed():
	start_game()



func _on_HUD_hud_message(msg):
	match msg:
		Hud.Msg.GAME_EXIT:
			end_game()
			$HUD/PauseDialog.hide()
		Hud.Msg.GAME_CONTINUE:
			get_tree().paused = false
		Hud.Msg.GAME_PAUSE:
			get_tree().paused = true
		Hud.Msg.GAME_RESTART:
			end_game()
			start_game()
			$HUD/PauseDialog.hide()

func _get_player_score(score_str):
	$HUD/ScoreLabel.text = score_str

func _game_over():
	$HUD/GameOverTimer.start()

func start_game():
	$Menu.visible = false
	$HUD.visible = true
	level = LEVEL.instance()
#	level.get_node("Player") \
#	.connect("show_score", self, "_get_player_score")
	level.connect("current_score", self, "_get_player_score")
	level.connect("game_over", self, "_game_over")
	add_child(level)

func end_game():
	level.queue_free()
	$HUD.visible = false
	$Menu.visible = true
