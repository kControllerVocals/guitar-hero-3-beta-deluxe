guitar_hero_cheats = [
	{
		name = AirGuitar
		name_text = "air guitar"
		var = Cheat_AirGuitar
		unlock_pattern = [
			65536
			4096
			256
			16
			1
			16
			256
			4096
			65536
		]
	}
	{
		name = PerformanceMode
		name_text = "performance mode"
		var = Cheat_PerformanceMode
		unlock_pattern = [
			1
			256
			16
			16
			256
			1
			16
			16
		]
	}
	{
		name = hyperspeed
		name_text = "hyperspeed"
		var = Cheat_Hyperspeed
		unlock_pattern = [
			16
			1
			256
			1
			16
			1
			256
			256
		]
	}
	{
		name = unlock
		all
		name_text = "unlocked all songs"
		var = Cheat_UnlockAll
		unlock_pattern = [
			16
			256
			1
			4096
			256
			1
			16
			256
			16
			256
			16
			256
			16
			256
			16
			256
		]
	}
]
guitar_hero_cheats_completed = [
	0
	0
	0
	0
]

script clear_cheats 
	change \{Cheat_AirGuitar = -1}
	change \{Cheat_PerformanceMode = -1}
endscript

script create_cheats_menu 
	if ($entering_cheat = 0)
		CreateScreenElement {
			type = ContainerElement
			id = cheats_container
			parent = root_window
			pos = (0.0, 0.0)
		}
		create_menu_backdrop texture = Venue_BG
		displaySprite parent = cheats_container tex = options_video_poster rot_angle = 1 pos = (640.0, 240.0) dims = (820.0, 410.0) just = [center center] z = 1 font = $video_settings_menu_font
		displayText {
			parent = cheats_container
			pos = (910.0, 402.0)
			just = [right center]
			text = "CHEATS"
			scale = 1.5
			rgba = [240 235 240 255]
			font = text_a5
			noshadow
		}
		displaySprite {
			parent = cheats_container
			tex = tape_H_03
			pos = (270.0, 185.0)
			rot_angle = -50
			scale = 0.5
			z = 20
		}
		displaySprite {
			parent = <id>
			tex = tape_H_03
			pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			z = 19
		}
		displaySprite {
			parent = cheats_container
			tex = tape_H_04
			pos = (930.0, 380.0)
			rot_angle = -120
			scale = 0.5
			z = 20
		}
		displaySprite {
			parent = <id>
			tex = tape_H_04
			pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			z = 19
		}
		cheats_create_guitar
	endif
	displaySprite parent = cheats_container id = cheats_hilite tex = white rgba = [40 60 110 255] rot_angle = 1 pos = (346.0, 382.0) dims = (230.0, 35.0) z = 2
	new_menu scrollid = cheats_scroll vmenuid = cheats_vmenu menu_pos = (360.0, 250.0) text_left spacing = -12 rot_angle = 1
	text_params = {parent = cheats_vmenu type = TextElement font = text_a3 rgba = [255 245 225 255] z_priority = 50 rot_angle = 1 scale = 1}
	text_params2 = {parent = cheats_vmenu type = TextElement font = text_a5 rgba = [255 245 225 255] z_priority = 50 rot_angle = 1 scale = 0.7}
	<text> = "locked"
	if ($Cheat_AirGuitar > 0)
		if ($Cheat_AirGuitar = 1)
			FormatText TextName = text "%c : ON" c = ($guitar_hero_cheats [0].name_text)
		else
			FormatText TextName = text "%c : OFF" c = ($guitar_hero_cheats [0].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		text = <text>
		id = Cheat_AirGuitar_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (346.0, 267.0)}}
			{pad_choose toggle_cheat params = {cheat = Cheat_AirGuitar id = Cheat_AirGuitar_Text index = 0}}
		]
	}
	<text> = "locked"
	if ($Cheat_PerformanceMode > 0)
		if ($Cheat_PerformanceMode = 1)
			FormatText TextName = text "%c : ON" c = ($guitar_hero_cheats [1].name_text)
		else
			FormatText TextName = text "%c : OFF" c = ($guitar_hero_cheats [1].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		text = <text>
		id = Cheat_PerformanceMode_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (346.0, 295.0)}}
			{pad_choose toggle_cheat params = {cheat = Cheat_PerformanceMode id = Cheat_PerformanceMode_Text index = 1}}
		]
	}
	<text> = "locked"
	if ($Cheat_Hyperspeed > 0)
		if ($Cheat_Hyperspeed = 1)
			FormatText TextName = text "%c : ON" c = ($guitar_hero_cheats [2].name_text)
		else
			FormatText TextName = text "%c : OFF" c = ($guitar_hero_cheats [2].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		text = <text>
		id = Cheat_Hyperspeed_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (346.0, 320.0)}}
			{pad_choose toggle_cheat params = {cheat = Cheat_Hyperspeed id = Cheat_Hyperspeed_Text index = 2}}
		]
	}
	CreateScreenElement {
		<text_params2>
		text = "locked"
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (346.0, 347.0)}}
		]
	}
	CreateScreenElement {
		<text_params>
		text = "enter cheat"
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (346.0, 382.0)}}
			{pad_choose enter_new_cheat}
		]
	}
	clean_up_user_control_helpers
	change user_control_pill_text_color = [0 0 0 255]
	change user_control_pill_color = [180 180 180 255]
	add_user_control_helper text = "SELECT" button = green z = 100
	add_user_control_helper text = "BACK" button = red z = 100
	add_user_control_helper text = "UP/DOWN" button = strumbar z = 100
	change entering_cheat = 0
endscript

script enter_new_cheat 
	disable_pause
	change \{entering_cheat = 1}
	ui_flow_manager_respond_to_action \{action = enter_new_cheat}
endscript

script cheats_morph_hilite \{time = 0.025}
	cheats_hilite :DoMorph pos = <pos> time = <time>
endscript
entering_cheat = 0

script destroy_cheats_menu 
	clean_up_user_control_helpers
	destroy_menu \{menu_id = cheats_scroll}
	if ScreenElementExists \{id = cheats_hilite}
		DestroyScreenElement \{id = cheats_hilite}
	endif
	if ($entering_cheat = 0)
		KillSpawnedScript \{name = cheats_watch_buttons}
		if ScreenElementExists \{id = cheats_container}
			DestroyScreenElement \{id = cheats_container}
		endif
		cheats_destroy_pressed_notes
	endif
endscript

script cheats_create_guitar 
	CreateScreenElement \{parent = cheats_container
		type = SpriteElement
		id = guitar_sprite
		just = [
			left
			center
		]
		texture = training_guitar
		pos = (1200.0, 545.0)
		rot_angle = 0
		rgba = [
			255
			255
			255
			255
		]
		scale = (1.0, 1.0)
		z_priority = 2}
endscript

script cheats_create_pressed_notes 
	x_offset = 67
	green_pos = (506.0, 543.0)
	red_pos = (<green_pos> + ((1.0, 0.0) * <x_offset>))
	yellow_pos = (<red_pos> + ((1.0, 0.0) * <x_offset>))
	blue_pos = (<yellow_pos> + ((1.0, 0.0) * <x_offset>))
	orange_pos = (<blue_pos> + ((1.0, 0.0) * <x_offset>))
	CreateScreenElement {
		parent = cheats_container
		type = SpriteElement
		id = green_pressed_sprite
		just = [center center]
		texture = training_guitar_button_down
		pos = <green_pos>
		rot_angle = 0
		rgba = [0 165 130 255]
		scale = (0.36, 0.36)
		z_priority = 3
	}
	CreateScreenElement {
		parent = cheats_container
		type = SpriteElement
		id = red_pressed_sprite
		just = [center center]
		texture = training_guitar_button_down
		pos = <red_pos>
		rot_angle = 0
		rgba = [230 80 90 255]
		scale = (0.36, 0.36)
		z_priority = 3
	}
	CreateScreenElement {
		parent = cheats_container
		type = SpriteElement
		id = yellow_pressed_sprite
		just = [center center]
		texture = training_guitar_button_down
		pos = <yellow_pos>
		rot_angle = 0
		rgba = [220 160 25 255]
		scale = (0.36, 0.36)
		z_priority = 3
	}
	CreateScreenElement {
		parent = cheats_container
		type = SpriteElement
		id = blue_pressed_sprite
		just = [center center]
		texture = training_guitar_button_down
		pos = <blue_pos>
		rot_angle = 0
		rgba = [0 135 210 255]
		scale = (0.36, 0.36)
		z_priority = 3
	}
	CreateScreenElement {
		parent = cheats_container
		type = SpriteElement
		id = orange_pressed_sprite
		just = [center center]
		texture = training_guitar_button_down
		pos = <orange_pos>
		rot_angle = 0
		rgba = [215 120 40 255]
		scale = (0.36, 0.36)
		z_priority = 3
	}
	hide_pressed_notes
endscript

script cheats_destroy_pressed_notes 
	safe_destroy \{id = green_pressed_sprite}
	safe_destroy \{id = red_pressed_sprite}
	safe_destroy \{id = yellow_pressed_sprite}
	safe_destroy \{id = orange_pressed_sprite}
	safe_destroy \{id = blue_pressed_sprite}
endscript

script cheats_watch_buttons 
	Wait \{0.75
		seconds}
	cheats_create_pressed_notes
	begin
	GetHeldPattern controller = ($player1_status.controller) nobrokenstring
	hide_pressed_notes
	check_button = 65536
	array_count = 0
	begin
	if (<hold_pattern> && <check_button>)
		show_pressed_note note = <array_count>
	endif
	<check_button> = (<check_button> / 16)
	array_count = (<array_count> + 1)
	repeat 5
	Wait \{1
		gameframe}
	repeat
endscript

script cheats_zoomin_guitar 
	event_handlers = [
		{pad_up create_cheat_guitar_strum}
		{pad_down create_cheat_guitar_strum}
		{pad_start ui_flow_manager_respond_to_action params = {action = new_cheat_finished}}
	]
	new_menu {
		scrollid = menu_new_cheat
		vmenuid = vmenu_new_cheat
		menu_pos = (0.0, 0.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	Menu_Music_Off
	SetMenuAutoRepeatTimes (60.0, 60.0)
	clean_up_user_control_helpers
	change user_control_pill_text_color = [0 0 0 255]
	change user_control_pill_color = [180 180 180 255]
	add_user_control_helper text = "PRESS START TO FINISH" button = start z = 100
	spawnscriptnow cheats_watch_buttons
	if ScreenElementExists id = guitar_sprite
		guitar_sprite :DoMorph scale = (1.0, 1.0) pos = (140.0, 545.0) time = 0.75
	endif
endscript

script cheats_zoomout_guitar 
	spawnscriptnow \{menu_music_on}
	SetMenuAutoRepeatTimes \{(0.3, 0.05)}
	KillSpawnedScript \{name = cheats_watch_buttons}
	cheats_destroy_pressed_notes
	if ScreenElementExists \{id = awardtext}
		DestroyScreenElement \{id = awardtext}
	endif
	KillSpawnedScript \{name = cheat_award_text}
	destroy_menu \{menu_id = menu_new_cheat}
	if ScreenElementExists \{id = guitar_sprite}
		guitar_sprite :DoMorph \{scale = (1.0, 1.0)
			pos = (1200.0, 545.0)
			time = 0.75}
	endif
	enable_pause
endscript

script create_cheat_guitar_strum 
	GetHeldPattern controller = ($player1_status.controller) nobrokenstring
	check_button = 65536
	array_count = 0
	switch <hold_pattern>
		case 65536
		SoundEvent event = Practice_Mode_Kick
		case 4096
		SoundEvent event = Practice_Mode_Snare
		case 256
		SoundEvent event = Practice_Mode_HiHatClosed
		case 16
		SoundEvent event = Practice_Mode_HiHatOpen
		case 1
		SoundEvent event = Practice_Mode_Crash2
		default
	endswitch
	GetArraySize $guitar_hero_cheats
	num_of_cheats = <array_size>
	<index> = 0
	begin
	pattern_array = ($guitar_hero_cheats [<index>].unlock_pattern)
	completed_index = ($guitar_hero_cheats_completed [<index>])
	if (<hold_pattern> = (<pattern_array> [<completed_index>]))
		printf channel = trchen "MATCH CHEAT: %s, STEP: %l" s = <index> l = <completed_index>
		SetArrayElement ArrayName = guitar_hero_cheats_completed GlobalArray index = <index> newvalue = (<completed_index> + 1)
		GetArraySize pattern_array
		if (<array_size> = ($guitar_hero_cheats_completed [<index>]))
			printf channel = trchen "CHEAT %s UNLOCKED!" s = <index>
			unlock_cheat cheat = ($guitar_hero_cheats [<index>].var) index = <index>
			SetArrayElement ArrayName = guitar_hero_cheats_completed GlobalArray index = <index> newvalue = 0
		endif
	else
		if (<hold_pattern> = (<pattern_array> [0]))
			printf channel = trchen "MATCH CHEAT: %s, STEP: 0" s = <index>
			SetArrayElement ArrayName = guitar_hero_cheats_completed GlobalArray index = <index> newvalue = 1
		else
			SetArrayElement ArrayName = guitar_hero_cheats_completed GlobalArray index = <index> newvalue = 0
		endif
	endif
	<index> = (<index> + 1)
	repeat <num_of_cheats>
endscript

script cheat_award_text show_unlock = 1
	if ScreenElementExists id = awardtext
		DestroyScreenElement id = awardtext
	endif
	award_text = ($guitar_hero_cheats [<index>].name_text)
	CreateScreenElement {
		type = TextElement
		id = awardtext
		parent = cheats_container
		pos = (360.0, 366.0)
		text = <award_text>
		font = text_a3
		scale = 1.1
		rgba = [255 255 255 255]
		just = [left center]
		z_priority = 25
	}
	if (<show_unlock> = 1)
		CreateScreenElement {
			type = TextElement
			id = awardtext_sub
			parent = awardtext
			pos = (1.0, 57.0)
			text = "unlocked"
			font = text_a3
			scale = 0.7
			rgba = [255 255 255 255]
			just = [left center]
			z_priority = 25
		}
	endif
	Wait 1.5 seconds
	doScreenElementMorph {
		id = awardtext
		alpha = 0
		time = 1
	}
endscript

script unlock_cheat 
	if (<cheat> = Cheat_UnlockAll)
		GlobalTags_UnlockAll songlist = GH3_General_Songs songs_only = 1
		GlobalTags_UnlockAll songlist = GH3_GeneralP2_Songs songs_only = 1
		GlobalTags_UnlockAll songlist = GH3_Bonus_Songs songs_only = 1
		SoundEvent event = Crowd_OneShots_Cheer_Close
		spawnscriptnow cheat_award_text params = {index = <index> show_unlock = 0}
		return
	endif
	if NOT (<cheat> > 0)
		SoundEvent event = Crowd_OneShots_Cheer_Close
		change globalname = <cheat> newvalue = 2
		spawnscriptnow cheat_award_text params = {index = <index>}
	endif
endscript

script toggle_cheat 
	if ($<cheat> > 0)
		if ($<cheat> = 1)
			change globalname = <cheat> newvalue = 2
			FormatText TextName = text "%c : OFF" c = ($guitar_hero_cheats [<index>].name_text)
			SetScreenElementProps id = <id> text = <text>
		else
			change globalname = <cheat> newvalue = 1
			FormatText TextName = text "%c : ON" c = ($guitar_hero_cheats [<index>].name_text)
			SetScreenElementProps id = <id> text = <text>
		endif
	else
		SetScreenElementProps id = <id> text = "locked"
	endif
endscript
