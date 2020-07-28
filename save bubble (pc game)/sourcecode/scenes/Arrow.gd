extends Area2D
var velocity = Vector2(20,0)

export (PackedScene) var Gcoin
export(PackedScene) var Scoin
export(PackedScene) var Plife
export(PackedScene) var Pinvisible
export(PackedScene) var Pshield
export(PackedScene) var Shield

func _ready():
	pass

func _process(delta):
	position += velocity
	if (position.x > utils.sizex or position.x < -150 or position.y > utils.sizey or position.y < -150):
		queue_free()
	pass



func _on_Arrow_area_entered(area):
	if area.is_in_group("shield"):
		create_item()


func create_item():
	var choose = int(rand_range(0,8))
	if choose == 0:
		create_power()
	else:
		
		create_coin()
	pass


func create_coin():
	var item = int(rand_range(0,2))
	var coinn
	if item == 0:
		 coinn = Gcoin
	else:
		 coinn = Scoin
	
	var no = 4
	print(no)
	$Sprite.hide()
	$CollisionShape2D.set_disabled(true)
	velocity = Vector2()
	for i in range (0,no):
		var coin = coinn.instance()
		add_child(coin)
		
		coin.global_position = $Path2D/PathFollow2D.global_position
		coin.global_rotation = 0
		$Path2D/PathFollow2D.offset += 70
	yield(utils.create_timer(5),"timeout")
	queue_free()

func create_power():
	var item = int(rand_range(0,3))
	var powerr
	$Sprite.hide()
	$CollisionShape2D.set_disabled(true)
	if item == 0:
		powerr = Plife
	
	elif item ==1:
		powerr = Pinvisible
	else:
		powerr = Pshield
	var power = powerr.instance()
	add_child(power)
	if int(rand_range(0,4)):
		velocity = Vector2()
	power.scale = Vector2(0.5,0.5)
	power.global_position = $Sprite.global_position
	power.global_rotation = 0
	
	
