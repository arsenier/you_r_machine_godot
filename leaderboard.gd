extends Node

signal logged_in(is_successfull)

var leaderboard = []

func get_leaderboard(limit = 10):
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var url = "http://localhost:8000/api/v1/leaderboard/top/" + str(limit) + "/"
	#var headers = ['accept: application/json']
	#$HTTPRequest.request(url, headers)
	
	#var auth = str("Basic ", Marshalls.utf8_to_base64(str(login, ":", password))) 
	#var headers=["Content-Type: application/json","Authorization: "+auth]
	var headers = []

	$HTTPRequest.request(url, headers, HTTPClient.METHOD_GET)
	#yield(_on_request_completed(), "completed")
	await $HTTPRequest.request_completed
	#print("Completed")
	return leaderboard

func _ready():
	pass


func _on_request_completed(result, response_code, headers, body):
	if(response_code != 200):
		return
	var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json["message"])
	#print(json)
	leaderboard = json
	#emit_signal("logged_in", true)
