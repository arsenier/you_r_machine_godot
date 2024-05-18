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


func _on_basic_auth_logged_in(is_successfull):
	queue_free()
