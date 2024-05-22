extends Node


func submit_score(score, user_id, username):
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var url = "http://localhost:8000/api/v1/leaderboard/"
	#var headers = ['accept: application/json']
	#$HTTPRequest.request(url, headers)
	
	var headers = ["Content-Type: application/json"]
	
	var data_to_send = {
		 "user_id": user_id,
		 "username": username,
		 "score": score
	}
	
	headers.append(get_parent().auth_header)
	print(headers)

	var json = JSON.stringify(data_to_send)
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)
	#var headers = ['accept: application/json']
	#$HTTPRequest.request(url, headers)
	
	#var auth = str("Basic ", Marshalls.utf8_to_base64(str(login, ":", password))) 
	#var headers=["Content-Type: application/json","Authorization: "+auth]

	#yield(_on_request_completed(), "completed")
	return await $HTTPRequest.request_completed
	#print("Submitted")

func _ready():
	pass


func _on_request_completed(result, response_code, headers, body):
	print(result)
	print(response_code)
	print(headers)
	print(body)
	if(response_code == 201):
		print("highscore submitted")
		return false
	print("error submitting highscore")
	return true
