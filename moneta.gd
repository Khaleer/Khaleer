extends Area2D

signal moneta_zebrana

func _on_moneta_body_entered(body):
	if body.is_in_group("gracz"):
		emit_signal("moneta_zebrana")
