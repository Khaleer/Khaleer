extends KinematicBody2D


export var szybkosc = 500
export var skok = -1000
export var grawitacja = 4000

onready var odpornosc_czas = $odpornosc

#lawa
export (int) var zycie = 3
#monety
var score = 0
signal zebrana

var velocity = Vector2.ZERO


func get_input():
	
	#Pamiętacie gdy wczesniej przy pomocy var velocity określiliśmy wartość Vector 2 na zero?
	#teraz robimy to ponownie, by postać gracza po puszczeniu strzałki w prawo / lewo nie biegła w nieskonczoność.
	velocity.x = 0 
	
	#aby program nie przestał sprawdzać czy gracz wciska klawisz, używamy pętli if (jezeli) czyli if(jeżeli) coś jest kliknięte
	#wykonaj polecenie.
	
	if Input.is_action_pressed("prawo"):
		velocity.x += szybkosc
		
		#Input.is_action_pressed() służy do sprawdzenia, czy gracz wcisnął klawisz, poniżej sprawiamy, że na wcześniej okreslonej
		#wartości velocity wykonuje się działanie matematyczne (+= oznacza, że wartość velocity.x przyjmie wartość szybkość)
		
	if Input.is_action_pressed("lewo"):
		velocity.x -= szybkosc


#funkcja _physic process wykonuje się non stop w naszej grze,
func _physics_process(delta):


	get_input()
#zauważ, że get_input() to nazwa funkcji którą określiliśmy powyżej. teraz przywołamy ją do działania w naszej grze
#poniżej sprawimy, by grawitacja działała co jedną klatkę (1fps) przy pomocy "delta" i co każdą klatkę wpływała na położenie gracza
	velocity.y += grawitacja * delta
	var snap = Vector2.DOWN * 16 if is_on_floor() else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	#oraz na koniec pozwólmy graczowi skakać, czyli do naszej pozycji w osi Y, dodać wartość skoku
	
	if Input.is_action_pressed("prawo"):
		velocity.x += szybkosc
		$AnimatedSprite.play("bieg_nowy")
		$AnimatedSprite.flip_h=false
		#Input.is_action_pressed() służy do sprawdzenia, czy gracz wcisnął klawisz, poniżej sprawiamy, że na wcześniej okreslonej
		#wartości velocity wykonuje się działanie matematyczne (+= oznacza, że wartość velocity.x przyjmie wartość szybkość)
		
	elif Input.is_action_pressed("lewo"):
		$AnimatedSprite.play("bieg_nowy")
		$AnimatedSprite.flip_h=true
	else:
		$AnimatedSprite.play("postoj")
	if Input.is_action_pressed("skok"):
		if is_on_floor():
			velocity.y = skok 
	$CanvasLayer/ZYCIE.set_text("pozostale zycie: "+ String(zycie))


func _ready():
	
	score = Ogolny.score
	$CanvasLayer/score_label.set_text("SCORE "+String(Ogolny.score))


func _on_Area2D_area_entered(area):
	
	if area.is_in_group("Enemy"):
		zycie -= 1
	if zycie <= 0:
		get_tree().change_scene("res://game_over.tscn")
		queue_free()

	
	
#	if odpornosc_czas.is_stopped():
#		odpornosc_czas.start()
		
		#if area.is_in_group("Enemy"):
#			zycie -= 1
#			$AnimationPlayer.play("niewidz")
#			$AnimationPlayer.play("obrazenia")
			
#		if zycie <= 0:
#				get_tree().change_scene("res://game_over.tscn")
#				queue_free()
	
	if area.is_in_group("bariera"):
		get_tree().change_scene("res://game_over.tscn")
		Ogolny.score -= Ogolny.score
	if area.is_in_group("coin1"):
		score+=1
		$CanvasLayer/score_label.set_text("SCORE "+String(score))
		Ogolny.score = score
		emit_signal("zebrana")

	if area.is_in_group("coin5"):
		score+=5
		$CanvasLayer/score_label.set_text("SCORE "+String(score))
		Ogolny.score = score
		emit_signal("zebrana")

	if area.is_in_group("coin2"):
		score+=2
		$CanvasLayer/score_label.set_text("SCORE "+String(score))
		Ogolny.score = score
		emit_signal("zebrana")


func _on_odpornosc_timeout():
	$AnimationPlayer.play("rest")
	
func przegrana():
	get_tree().change_scene("res://game_over.tscn")
	queue_free()
