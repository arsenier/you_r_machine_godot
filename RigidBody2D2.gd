extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var torque = 1
var I = 0
var T = 0.1
var inp = 0
var out = 0
var I2 = 0
var T2 = 0.1
var inp2 = 0
var out2 = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = 0
	angular_velocity
	
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	
	inp2 = direction*30
	var err2 = inp2 - angular_velocity
	out2 = err2*10000

	inp = out2
	var err = inp - out
	I += err*delta/T
	out = I*torque
	
	print(err, " ", I, " ", out)
	
	apply_torque(out)
