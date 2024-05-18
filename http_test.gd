extends Node

signal logged_in(is_successfull)

func auth(login, password):
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var url = "http://localhost:8000/api/v1/demo-auth/basic-auth/"
	#var headers = ['accept: application/json']
	#$HTTPRequest.request(url, headers)
	
	var auth = str("Basic ", Marshalls.utf8_to_base64(str(login, ":", password))) 
	var headers=["Content-Type: application/json","Authorization: "+auth]

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
	emit_signal("logged_in", true)
