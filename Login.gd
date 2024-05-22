extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_button_pressed():
	var login = $Screen/MarginContainer/VBoxContainer/LoginEdit.text
	var password = $Screen/MarginContainer/VBoxContainer/PasswordEdit.text
	
	$BasicAuth.auth(login, password)


func _on_basic_auth_logged_in(is_successfull, login, user_id):
	var status_label = $Screen/MarginContainer/VBoxContainer/IncorrectLabel
	if is_successfull:
		status_label.set("theme_override_colors/font_color", Color(0, 1, 0))
		status_label.text = "Welcome, " + login
		await get_tree().create_timer(4).timeout
		queue_free()
		return

	status_label.set("theme_override_colors/font_color", Color(1, 0, 0))
	status_label.text = "incorrect login or password"
	

func _on_button_pressed():
	queue_free()
