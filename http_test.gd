extends Node

signal logged_in(is_successfull, login, user_id)
signal auth_header(header)

func auth(login, password):
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var url = "http://localhost:8000/api/v1/oauth/basic-auth/"
	#var headers = ['accept: application/json']
	#$HTTPRequest.request(url, headers)
	
	var auth = str("Basic ", Marshalls.utf8_to_base64(str(login, ":", password)))
	var headers=["Content-Type: application/json","Authorization: "+auth]
	emit_signal("auth_header", "Authorization: "+auth)

	$HTTPRequest.request(url, headers, HTTPClient.METHOD_GET)

func _ready():
	#$HTTPRequest.request_completed.connect(_on_request_completed)
	#var url = "http://test:pass@localhost:8000/api/v1/demo-auth/basic-auth/"
	##var headers = ['accept: application/json']
	##$HTTPRequest.request(url, headers)
	#
	#var auth = str("Basic ", Marshalls.utf8_to_base64(str("user", ":", "password"))) 
	#var headers=["Content-Type: application/json","Authorization: "+auth]
#
	#$HTTPRequest.request(url, headers, HTTPClient.METHOD_GET)
	pass


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json["message"])
	print(json)
	print(response_code)
	if(response_code == 200):
		emit_signal("logged_in", response_code == 200, json["username"], 0)
	else:
		emit_signal("logged_in", response_code == 200, "", -1)
