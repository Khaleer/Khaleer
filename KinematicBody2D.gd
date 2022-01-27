extends KinematicBody2D

#kod wykonuje się od góry do dołu, czyli po kolei

#Tutaj okreslamy wartości dzięki którym poruszać się będzie nasza postać
# var - służy nam do określenia w programie pewnej wartości, np zdrowia postaci lub ilości punktów które otrzymamy za zebranie pieniążka.

var szybkosc = 1200
var skok = -1000
var grawitacja = 2000

# velocity (ang.prędkość) służy do późniejszczego określenia pozycji gracza na osi X i Y
# Vector2 posiada dwie wartości Vector2(wartość X, wartość Y)
#przy pomocy .ZERO obu tym wartościom nadajemy wartość "0"

var velocity = Vector2.ZERO

# "func" określa funkcję, czyli polecenie dla komputera, dzięki któremu możemy np sprawić, że postać się porusza
# gdy spełnione zostaną określone warunki

# func get_input(): - we wnętrzu tej funkcji każemy godotowi przyjąć i przeanalizować to co gracz wciska na klawiaturze.

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
	velocity = move_and_slide(velocity, Vector2.UP)
	#oraz na koniec pozwólmy graczowi skakać, czyli do naszej pozycji w osi Y, dodać wartość skoku
	if Input.is_action_pressed("skok"):
		if is_on_floor():
			velocity.y = skok


func _ready():
	pass 


