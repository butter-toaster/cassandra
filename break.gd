extends Button
var canpress = true
var talknumber = 0
var xscale = 8
var yscale = 8
var shakesleft = 10

func _on_pressed() -> void:
	if canpress == true:
		canpress = false
		talknumber += 1
		%bargingsfx.pitch_scale = randf_range(0.5, 0.55)
		_screenshake()
		%bargingsfx.play()
		create_tween().tween_property(self, "xscale", 0, 0.26)
		create_tween().tween_property(self, "yscale", 0, 0.26)
		
		match talknumber:
			1:
				await get_tree().create_timer(0.3).timeout
				$"..".timemult = 0.6
				$"..".pitchmult = 1.4
				$".."._type("I WILL SHOOT HER! DON'T YOU COME ANY CLOSER.", %textleft, 1)
				$".."._talk(%mantalksfx)
				await get_tree().create_timer(1.8).timeout
				canpress = true
			2:
				canpress = false
				await get_tree().create_timer(2).timeout
				%textleft.modulate = Color("8f63da")
				%break.hide()
				$".."._type("PLEASE... OFFICERS! HELP ME-", %textleft, 1)
				$".."._talk(%womantalksfx)
				await get_tree().create_timer(0.75).timeout
				%gunshots.play()
				%textleft.modulate = Color("7547bdff")
				%textleft.text = "PLEASE... OFFICERS! HELP"
				await get_tree().create_timer(0.5).timeout
				%gunshots.play()
				%textleft.modulate = Color("7547bdff")
				%textleft.text = "PLEASE... OFFICERS"
				await get_tree().create_timer(0.7).timeout
				%gunshots.play()
				%textleft.modulate = Color("48267aff")
				%textleft.text = "HEL"
				await get_tree().create_timer(0.23).timeout
				_bargingsequence()
				await get_tree().create_timer(0.4).timeout
				%gunshots.play()
				%textleft.modulate = Color("2b154bff")
				%textleft.text = "HE"
				await get_tree().create_timer(0.46).timeout
				%gunshots.play()
				%textleft.modulate = Color("060210ff")
				%textleft.text = "H"
				await get_tree().create_timer(0.6).timeout
				%gunshots.play()
				await get_tree().create_timer(0.6).timeout
				
				

func _screenshake() -> void:
	shakesleft -= 1
	var xpos = randf_range((xscale * -1), xscale)
	var ypos = randf_range((yscale * -1), yscale)
	%cam.offset = Vector2(xpos, ypos)
	
	await get_tree().create_timer(0.02).timeout
	if shakesleft <= 0:
		shakesleft = 13
		xscale = 8
		yscale = 8
		return
	else:
		_screenshake()
		
func _bargingsequence() -> void:
	create_tween().tween_property(self, "xscale", 0, 0.26)
	create_tween().tween_property(self, "yscale", 0, 0.26)
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.5, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.7, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.5, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.6, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.7, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.5, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.5, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	_screenshake()
	%bargingsfx.pitch_scale = randf_range(0.8, 0.55)
	%bargingsfx.play()
	await get_tree().create_timer(0.5).timeout
	xscale = 16
	yscale = 16
	_screenshake()
	%breakingsfx.play()
	%opendoor.show()
	await get_tree().create_timer(0.2).timeout
	var policetween = create_tween().set_parallel(true)
	policetween.tween_property(%officer1, "global_position:x", -300, 1)
	policetween.tween_property(%officer2, "global_position:x", -300, 1.3)
	policetween.tween_property(%officer3, "global_position:x", -300, 1.75)
	var t2 = create_tween()
	t2.tween_property(%endingnoisesfx,"volume_db", 20, 3)
	await t2.finished
	get_tree().change_scene_to_file("res://ending.tscn")
	
	
	
