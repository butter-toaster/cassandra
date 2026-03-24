extends Control
var canclick = false
var cantalk = false
var dialoguenumber = 0
var timesleft = 0
var timemult = 1
var pitchmult = 1
var volscale = 1
var temppromptstop = false

func _ready() -> void:
	%door.modulate = Color("ffffff00")
	%clickdetector.pressed.connect(_dialogueclick)
	%clickindicator.modulate = Color("ffffff00")
	%textright.modulate = Color("8f63da")
	%textleft.modulate = Color.WHITE
	
	await get_tree().create_timer(3).timeout
	var introdoor = create_tween()
	introdoor.tween_property(%door, "modulate", Color.WHITE, 3)
	var introambience = create_tween()
	introambience.tween_property(%ambiencesfx, "volume_db", -8, 3).from(-40)
	await introdoor.finished
	%officerknockingsfx.play()
	await get_tree().create_timer(1).timeout
	dialoguenumber = 1
	_type("Officer Savior, Ward County Police Department.", %textleft, 1)
	_talk(%officertalksfx)
	
func _type(dialogue: String, side: RichTextLabel, times) -> void:
	side.text = dialogue
	side.visible_ratio = 0
	cantalk = true
	timesleft += times
	timesleft -= 1
	

		
	var dialoguebegin = create_tween()
	var duration = dialogue.length() * 0.05 * timemult
	dialoguebegin.tween_property(side, "visible_ratio", 1.0, duration)
	await dialoguebegin.finished
	cantalk = false
	if timesleft <= 0 and temppromptstop ==false:
		timesleft = 0
		await get_tree().create_timer(0.5).timeout
		canclick = true
		create_tween().tween_property(%clickindicator, "modulate", Color.WHITE, 0.22)

func _talk(speaker: AudioStreamPlayer2D) -> void:
	var pitch = randf_range(0.98, 1.02)
	speaker.pitch_scale = pitch * pitchmult
	speaker.volume_db = -8 * volscale
	speaker.play()
	%dialoguenoisetimer.wait_time = 0.05 * timemult
	%dialoguenoisetimer.start()
	
	await %dialoguenoisetimer.timeout
	if cantalk == true:
		_talk(speaker)

func _reset() -> void:
	%textleft.text = ""
	%textright.text = ""

func _dialogueclick() -> void:
	if canclick == true:
		create_tween().tween_property(%clickindicator, "modulate", Color("ffffff00"), 0.22)
		_reset()
		print("clicked")
		canclick = false
		dialoguenumber += 1
		match dialoguenumber:
			2:
				await get_tree().create_timer(3).timeout
				%officerknockingsfx.play()
				await get_tree().create_timer(1).timeout
				_type("Officer Savior, Ward County Police-", %textleft, 2)
				_talk(%officertalksfx)
				await get_tree().create_timer(1.5).timeout
				_type("Hello.", %textright, 0)
				_talk(%womantalksfx)
			3:
				_type("Where's your husband at, miss?", %textleft, 2)
				_talk(%officertalksfx)
				await get_tree().create_timer(4.1).timeout
				_type("I think you have the wrong house.", %textright, 0)
				_talk(%womantalksfx)
			4:
				await get_tree().create_timer(2).timeout
				%textleft.modulate = Color("606060ff")
				volscale = 2.5
				_type("Do you think he's onto her?", %textleft, 2)
				_talk(%officertalksfx)
				await get_tree().create_timer(3).timeout
				_type("I'm not sure. Listen in.", %textleft, 0)
				_talk(%officertalksfx)
			5:
				%textleft.modulate = Color.WHITE
				volscale = 1
				await get_tree().create_timer(2).timeout
				_type("Hello?", %textright, 3)
				_talk(%womantalksfx)
				await get_tree().create_timer(2).timeout
				_type("Look, miss, we've gotten... noise complaints, around this location.", %textleft, 0)
				_talk(%officertalksfx)
				%dooropenandslam.play()
				await get_tree().create_timer(5).timeout
				_type("Is everybody okay over here?", %textleft, 0)
				_talk(%officertalksfx)
			6:
				_type("There's been some strange noises behind this house. Nothing from inside here though.", %textright, 1)
				_talk(%womantalksfx)
			7:
				_type("Understood, but is everybody okay over here?", %textleft, 1)
				_talk(%officertalksfx)
			8:
				await get_tree().create_timer(4).timeout
				_type("We're fine.", %textright, 2)
				_talk(%womantalksfx)
				await get_tree().create_timer(3.2).timeout
				_type("We?", %textleft, 0)
				_talk(%officertalksfx)
			9:
				await get_tree().create_timer(4).timeout
				_type("As in, everybody around this area.", %textright, 1)
				_talk(%womantalksfx)
			10:
				_type("Alright miss, is it alright if you step out and point us in the direction of these noises?", %textleft, 1)
				_talk(%officertalksfx)
			11:
				%guncocking.play()
				await get_tree().create_timer(3.3).timeout
				_type("I don't think I can.", %textright, 2)
				_talk(%womantalksfx)
				await get_tree().create_timer(3).timeout
				_type("Like I said though, you might want to investigate into the people behind our house.", %textright, 0)
				_talk(%womantalksfx)
			12:
				_type("Right, we'll get straight to it. Thank you.", %textleft, 3)
				_talk(%officertalksfx)
				await get_tree().create_timer(3.6).timeout
				_type("No, really,", %textright, 0)
				_talk(%womantalksfx)
				await get_tree().create_timer(1.3).timeout
				_type("Thank you.", %textright, 0)
				_talk(%womantalksfx)
			13:
				await get_tree().create_timer(1).timeout
				var t1 = create_tween().set_parallel(true)
				t1.tween_property(%door, "global_position:x", -764, 4.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
				t1.tween_property(%door2, "global_position:x", 764, 4.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
				%textright.modulate = Color.WHITE
				%textleft.modulate = Color("d34b56ff")
				await get_tree().create_timer(6.5).timeout
				_type("Showtime.", %textright, 1)
				_talk(%officertalksfx)
			14:
				%textright.modulate = Color("606060ff")
				volscale = 2.5
				_type("Suspect spotted in the back of the house, possible 10-32. Concealing it right now.", %textright, 3)
				_talk(%officertalksfx)
				await get_tree().create_timer(6).timeout
				_type("Call in EMS for the female, notable limping in her legs.", %textright, 0)
				_talk(%officertalksfx)
				await get_tree().create_timer(5).timeout
				_type("412, we're gonna need you to send in another unit.", %textright, 0)
				_talk(%officertalksfx)
			15:
				%textright.modulate = Color.WHITE
				volscale = 1
				await get_tree().create_timer(1).timeout
				_type("Dispatch just told her to lock herself in.", %textright, 3)
				_talk(%officertalksfx)
				await get_tree().create_timer(4).timeout
				_type("It's now or-", %textright, 0)
				_talk(%officertalksfx)
				await get_tree().create_timer(0.6).timeout
				%textleft.modulate = Color("d34b56ff")
				_type("Hello?", %textleft, 0)
				_talk(%mantalksfx)
				await get_tree().create_timer(0.3).timeout
				%ambiencesfx.volume_db = -80
			16:
				await get_tree().create_timer(6).timeout
				temppromptstop = true
				timemult = 2
				pitchmult = 0.7
				_type("If you don't reveal yourselves, her goddamn blood becomes my new wallpaper.", %textleft, 0)
				_talk(%mantalksfx)
				await get_tree().create_timer(7.8).timeout
				var t = create_tween()
				t.tween_property(%break, "modulate", Color.WHITE, 3)
				
