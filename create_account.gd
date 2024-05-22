extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func error_text(text):
	var status_label = $Screen/MarginContainer/VBoxContainer/IncorrectLabel
	status_label.set("theme_override_colors/font_color", Color(1, 0, 0))
	status_label.text = text

func success_text(text):
	var status_label = $Screen/MarginContainer/VBoxContainer/IncorrectLabel
	status_label.set("theme_override_colors/font_color", Color(0, 1, 0))
	status_label.text = text

func _on_create_button_pressed():
	var box = $Screen/MarginContainer/VBoxContainer
	var username = box.get_node("LoginEdit").text
	var pass1 = box.get_node("PasswordEdit").text
	var pass2 = box.get_node("PasswordEdit2").text
	var status_label = box.get_node("IncorrectLabel")
	
	if username.length() == 0 or pass1.length() == 0 or pass2.length() == 0:
		error_text("fill all fields")
		return
	
	if pass1 != pass2:
		error_text("passwords doesn't match")
		return
	
	create_account(username, pass1)
	

func create_account(login, password):
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var url = "http://localhost:8000/api/v1/oauth/users/"
	#var headers = ['accept: application/json']
	#$HTTPRequest.request(url, headers)
	
	var headers = ["Content-Type: application/json"]
	
	var data_to_send = {
  		"username": login,
  		"password": password
	}

	var json = JSON.stringify(data_to_send)
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json["message"])
	print(json)
	print(response_code)
	if(response_code == 201):
		success_text("Created account!\nusername: " + json["username"])
		#emit_signal("logged_in", response_code == 200, json["username"])
	#else:
		#emit_signal("logged_in", response_code == 200, "")


func _on_button_pressed():
	queue_free()
