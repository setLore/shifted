extends Node2D
var score: int = 0
@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _setup_level() -> void:
	var meats = $LevelRoot.get_node_or_null("Meats")
	if meats:
		for enemy in meats.get_children():
			enemy.collected.connect(increase_score)
	
	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
	
	
func _on_player_died(body):
	body.die()
	print("player killed")
	
func increase_score() -> void:
	score += 1
	score_label.text = "SCORE: %s" % score
	
