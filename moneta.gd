extends Area2D

signal moneta_zebrana

func _on_moneta_body_entered(body):
	if body.is_in_group("gracz"):
		emit_signal("moneta_zebrana")




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
		
		
		
	score = Ogolny.score
	$CanvasLayer/score_label.set_text("SCORE "+String(Ogolny.score))
