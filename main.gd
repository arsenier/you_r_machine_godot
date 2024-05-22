extends Control

@export var login_scn: PackedScene
@export var create_user_scn: PackedScene

var auth_header = ""
var is_logged_in = false
var username = ""
var user_id = 0

var login_button

# Called when the node enters the scene tree for the first time.
func _ready():
	login_button = $ColorRect/HBoxContainer/MarginContainer/VBoxContainer/Login


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if is_logged_in:
		auth_header = ""
		is_logged_in = false
		username = ""
		user_id = -1
		login_button.text = "LOGIN"
		$ColorRect/HBoxContainer/MarginContainer/VBoxContainer/LoggedIn.text = "Not logged in"
		return
		
	var login = login_scn.instantiate()
	add_child(login)
	$Login/BasicAuth.connect('auth_header', save_header)
	$Login/BasicAuth.connect('logged_in', save_username)
	#$login/BasicAuth.auth_header.connect('save_header')
	
func save_header(new_auth_header):
	auth_header = new_auth_header

func save_username(is_successful, new_username, user_id):
	is_logged_in = is_successful
	username = new_username
	user_id = user_id
	if is_logged_in:
		$ColorRect/HBoxContainer/MarginContainer/VBoxContainer/LoggedIn.text = "Logged in as: " + username
		login_button.text = "LOGOUT"

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


func _on_create_user_pressed():
	var scn = create_user_scn.instantiate()
	add_child(scn)
	#$Login/BasicAuth.connect('auth_header', save_header)


func _on_submit_pressed():
	var score = $ColorRect/HBoxContainer/CenterContainer/HBoxContainer/SpinBox.value
	$submitScore.submit_score(score, user_id, username)
