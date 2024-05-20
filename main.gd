extends Control

@export var login_scn: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var login = login_scn.instantiate()
	add_child(login)

func get_leaderboard_entry(max_width, place, username, score):
	#print(max_width, place, username, score)
	var score_width = max_width - 5 - username.length()
	var score_padded = str(score).lpad(score_width)
	var out = str(place).lpad(2) + ": " + username + score_padded
	return out

func _on_highscores_pressed():
	
	var limit = $ColorRect/HBoxContainer/MarginContainer/VBoxContainer/SpinBox.value
	var leaderboard = await $leaderboard.get_leaderboard(limit)
	
	$ColorRect/HBoxContainer/MarginContainer/VBoxContainer/ItemList.clear()
	var place = 0
	for record in leaderboard:
		var entry = get_leaderboard_entry(26, place, record.username, record.score)
		#print(entry)
		$ColorRect/HBoxContainer/MarginContainer/VBoxContainer/ItemList.add_item(entry, null, false)
		place += 1
