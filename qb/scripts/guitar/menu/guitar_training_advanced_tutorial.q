training_advanced_techniques_tutorial_script = [
	{
		call = training_advanced_techniques_tutorial_startup
	}
	{
		time = 100
		call = training_4_1_show_title
	}
	{
		call = training_4_1_explain
	}
	{
		call = training_4_2_explain
	}
	{
		call = training_4_2_show_guitar
	}
	{
		call = training_4_2_zoom_guitar
	}
	{
		call = training_4_2_wait_for_hammeron_complete
	}
	{
		call = training_4_2_complete_message
	}
	{
		call = training_4_2_end
	}
	{
		call = training_4_3_start_gem_scroller
	}
	{
		rel_time = 3500
		call = training_4_3_explain
	}
	{
		call = training_4_3_wait_for_hammerons
	}
	{
		call = training_4_3_complete_message
	}
	{
		call = training_4_4_explain
	}
	{
		call = training_4_4_show_guitar
	}
	{
		call = training_4_4_zoom_guitar
	}
	{
		call = training_4_4_wait_for_pulloff_complete
	}
	{
		call = training_4_4_complete_message
	}
	{
		call = training_4_4_end
	}
	{
		call = training_4_5_start_gem_scroller
	}
	{
		rel_time = 3500
		call = training_4_5_explain
	}
	{
		call = training_4_5_wait_for_hammerons
	}
	{
		call = training_4_5_complete_message
	}
	{
		call = training_advanced_techniques_tutorial_1_end
	}
]

script training_advanced_techniques_tutorial_startup 
	training_init_session
	disable_pause
	LaunchEvent \{type = unfocus
		target = root_window}
	create_training_pause_handler
endscript

script training_4_1_show_title 
	CreateScreenElement {
		type = TextElement
		parent = training_container
		id = lesson_title_text
		just = [center center]
		pos = (640.0, 350.0)
		font = fontgrid_title_gh3
		text = "Hammer-On and Pull-Off Tutorial"
		scale = 1.0
		rgba = ($training_text_color)
	}
	Wait \{3
		seconds}
	safe_destroy \{id = lesson_title_text}
endscript

script training_4_1_explain 
	training_set_lesson_header_text \{text = "LESSON 1: STRING BASICS"}
	training_set_lesson_header_body \{text = ""}
	training_show_lesson_header
	training_play_sound \{Sound = EN_Tutorial_4A_01_God
		Wait}
endscript

script training_4_2_explain 
	training_set_lesson_header_text \{text = "LESSON 2: HAMMER-ON FINGERING"}
	training_set_lesson_header_body \{text = ""}
	training_show_lesson_header
endscript

script training_4_2_show_guitar 
	CreateScreenElement {
		parent = training_container
		type = SpriteElement
		id = guitar_sprite
		just = [center center]
		texture = training_guitar
		pos = (630.0, 400.0)
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = (0.4, 0.4)
		z_priority = 4
	}
	training_create_fret_finger_sprites
	pose_fret_fingers color = none
	training_create_strum_sprites
	pose_strum_fingers pos = middle
	training_play_sound Sound = EN_Tutorial_4B_01_God
	Wait 20 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 6.15 pos = (360.0, 360.0) scale = 0.7
	training_add_arrow id = training_strum_arrow life = 4.0 pos = (850.0, 360.0) scale = 0.7
	pose_fret_fingers color = green
	Wait 1.0 seconds ignoreslomo
	pose_strum_fingers pos = down
	Wait 1.0 seconds ignoreslomo
	pose_strum_fingers pos = middle
	Wait 4.2 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 5.0 pos = (385.0, 360.0) scale = 0.7
	pose_fret_fingers color = green_red
	Wait 5 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 5.0 pos = (420.0, 360.0) scale = 0.7
	pose_fret_fingers color = green_red_yellow
	training_wait_for_sound Sound = EN_Tutorial_4B_01_God
endscript

script training_4_2_zoom_guitar 
	training_set_lesson_header_body text = "1. Play Green normally (strum)\\n2. Hammer-on red (no strum)\\n3. Hammer-on yellow (no strum)"
	training_show_lesson_header
	training_set_task_header_body text = "Hit 3 hammer-on sequences to continue"
	training_show_task_header
	hide_strum_fingers
	hide_fret_fingers
	if ScreenElementExists id = guitar_sprite
		guitar_sprite :DoMorph scale = (1.0, 1.0) pos = (1100.0, 400.0) time = 0.75
	endif
	training_play_sound Sound = EN_Tutorial_4B_02_God
	Wait 1 seconds ignoreslomo
endscript

script training_4_2_wait_for_hammeron_complete 
	if ScreenElementExists id = menu_tutorial
		LaunchEvent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	event_handlers = [
		{pad_up training_hammeron_strummed_guitar}
		{pad_down training_hammeron_strummed_guitar}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	change LESSON_COMPLETE = 0
	change training_hammerons_played = 0
	spawnscriptnow training_watch_buttons id = training_spawned_script
	begin
	if ($LESSON_COMPLETE = 1)
		break
	endif
	Wait 1 gameframe
	repeat
	if ScreenElementExists id = menu_tutorial
		LaunchEvent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
		create_training_pause_handler
	endif
	KillSpawnedScript name = training_watch_buttons
	hide_pressed_notes
	Wait 1 seconds ignoreslomo
endscript

script training_hammeron_strummed_guitar 
	if ($LESSON_COMPLETE = 1)
		return
	endif
	printf \{channel = hammeron
		"Strummed guitar........."}
	KillSpawnedScript \{name = training_watch_for_hammeron}
	spawnscriptnow \{training_watch_for_hammeron
		id = training_spawned_script}
endscript

script training_count_buttons_pressed 
	GetHeldPattern controller = ($player1_status.controller) nobrokenstring
	check_button = 65536
	array_count = 0
	note_played = 0
	notes_played = 0
	begin
	if (<hold_pattern> && <check_button>)
		note_played = <array_count>
		notes_played = (<notes_played> + 1)
	endif
	<check_button> = (<check_button> / 16)
	array_count = (<array_count> + 1)
	repeat 5
	return notes_played = <notes_played>
endscript
training_hammerons_played = 0
notes_played = 0

script training_watch_for_hammeron 
	printf channel = hammeron "training_watch_for_hammeron......"
	training_clear_notes_pressed
	training_count_buttons_pressed
	if (<notes_played> != 1)
		return
	endif
	GetHeldPattern controller = ($player1_status.controller) nobrokenstring
	check_button = 65536
	if (<hold_pattern> && <check_button>)
		training_press_note note = 0
		training_hit_note note = 0
		spawnscriptnow Battle_SFX_Repair_Broken_String params = {num_strums = ($training_notes_strummed [0]) player_pan = 1 difficulty = easy}
		wait_time = 0
		begin
		GetHeldPattern controller = ($player1_status.controller) nobrokenstring
		check_button = 273
		if (<hold_pattern> && <check_button>)
			training_clear_notes_pressed
			printf channel = hammeron "failed..."
			return
		endif
		check_button = 4096
		if (<hold_pattern> && <check_button>)
			printf channel = hammeron "red pressed..."
			break
		endif
		wait_time = (<wait_time> + 1)
		if (<wait_time> >= 60)
			printf channel = hammeron "times up..."
			training_clear_notes_pressed
			return
		endif
		Wait 1 gameframe
		repeat
		training_press_note note = 1
		training_hit_note note = 1
		spawnscriptnow Battle_SFX_Repair_Broken_String params = {num_strums = ($training_notes_strummed [0]) player_pan = 1 difficulty = easy}
		wait_time = 0
		begin
		GetHeldPattern controller = ($player1_status.controller) nobrokenstring
		check_button = 17
		if (<hold_pattern> && <check_button>)
			training_clear_notes_pressed
			printf channel = hammeron "failed..."
			return
		endif
		check_button = 256
		if (<hold_pattern> && <check_button>)
			break
		endif
		wait_time = (<wait_time> + 1)
		if (<wait_time> >= 60)
			training_clear_notes_pressed
			return
		endif
		Wait 1 gameframe
		repeat
		spawnscriptnow Battle_SFX_Repair_Broken_String params = {num_strums = ($training_notes_strummed [0]) player_pan = 1 difficulty = easy}
		training_press_note note = 2
		training_hit_note note = 0
		training_hit_note note = 1
		training_hit_note note = 2
		change training_hammerons_played = ($training_hammerons_played + 1)
		if ($training_hammerons_played = 1)
			training_play_sound Sound = EN_Tutorial_God_Positive_02
		endif
		if ($training_hammerons_played >= 3)
			change LESSON_COMPLETE = 1
		endif
		Wait 2 seconds ignoreslomo
		training_clear_notes_pressed
	endif
endscript

script training_press_note 
	FormatText checksumname = note_tuned 'note_tuned_%a' a = <note>
	CreateScreenElement {
		parent = training_container
		type = SpriteElement
		id = <note_tuned>
		just = [center center]
		texture = training_guitar_button_tuned
		pos = ((442.0, 396.0) + (1.0, 0.0) * (<note> * 67))
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = (0.36, 0.36)
		z_priority = 7
	}
endscript

script training_clear_notes_pressed 
	printf \{channel = hammeron
		"training_clear_notes_pressed...."}
	safe_destroy \{id = note_tuned_0}
	safe_destroy \{id = note_tuned_1}
	safe_destroy \{id = note_tuned_2}
endscript

script training_4_2_complete_message 
	safe_destroy id = guitar_sprite
	training_destroy_fret_finger_sprites
	training_destory_strum_sprites
	training_hide_lesson_header
	training_hide_task_header
	training_clear_notes_pressed
	training_destroy_pressed_notes
	CreateScreenElement {
		type = TextElement
		parent = training_container
		id = lesson_title_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Hammer-On Lesson Complete!"
		scale = 1.0
		rgba = ($training_text_color)
	}
	training_play_sound Sound = EN_Tutorial_4B_03_God Wait
	DestroyScreenElement id = lesson_title_text
endscript

script training_4_2_end 
	KillSpawnedScript \{name = training_watch_buttons}
	destroy_menu \{menu_id = menu_tutorial_4_2}
	training_destroy_pressed_notes
	safe_destroy \{id = guitar_sprite}
	training_destroy_fret_finger_sprites
	training_destory_strum_sprites
endscript

script training_4_3_start_gem_scroller 
	destroy_band
	training_set_lesson_header_text \{text = "LESSON 3: HAMMER-ONS"}
	training_set_lesson_header_body \{text = ""}
	training_show_lesson_header
	change \{training_song_over = 0}
	change \{structurename = player1_status
		current_health = 1.0}
	start_gem_scroller song_name = Tutorial_4C difficulty = medium difficulty2 = easy StartTime = 0 device_num = ($player1_status.controller) training_mode = 1
	KillSpawnedScript \{name = update_score_fast}
	change \{notes_hit = 0}
endscript

script training_4_3_explain 
	setslomo 0.0
	setslomo_song slomo = 0.0
	if ScreenElementExists id = menu_tutorial
		LaunchEvent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	event_handlers = [
		{hit_notesp1 lesson4_hammeron_note}
		{song_wonp1 training_song_won}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	training_play_sound Sound = EN_Tutorial_4C_01_God Wait
	training_set_task_header_body text = "Hit 8 notes using the hammer-on technique"
	training_show_task_header
	Wait 1 seconds ignoreslomo
	setslomo 1.0
	setslomo_song slomo = 1.0
endscript

script training_4_3_wait_for_hammerons 
	change \{training_hammerons_played = 0}
	begin
	if ($training_song_over = 1)
		break
	endif
	if ($training_hammerons_played >= 8)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	if ScreenElementExists \{id = menu_tutorial}
		LaunchEvent \{type = unfocus
			target = menu_tutorial}
		destroy_menu \{menu_id = menu_tutorial}
		create_training_pause_handler
	endif
endscript

script lesson4_hammeron_note 
	if (<hammer_strum> = 1)
		change training_hammerons_played = ($training_hammerons_played + 1)
		FormatText TextName = notes_hit "Notes Hit %a / 8" a = ($training_hammerons_played)
		if ScreenElementExists id = notes_hit_text
			DestroyScreenElement id = notes_hit_text
		endif
		CreateScreenElement {
			type = TextElement
			parent = training_container
			id = notes_hit_text
			just = [center center]
			pos = (640.0, 200.0)
			font = ($training_font)
			text = <notes_hit>
			scale = 1.0
			rgba = ($training_text_color)
		}
		if ($training_hammerons_played = 1)
			training_play_sound Sound = EN_Tutorial_God_Positive_01
		endif
	endif
endscript

script training_4_3_complete_message 
	if ScreenElementExists id = notes_hit_text
		DestroyScreenElement id = notes_hit_text
	endif
	training_hide_lesson_header
	training_hide_task_header
	PauseGame
	PauseGh3Sounds
	KillCamAnim name = ch_view_cam
	kill_gem_scroller
	destroy_bg_viewport
	setup_bg_viewport
	PlayIGCCam {
		id = cs_view_cam_id
		name = ch_view_cam
		viewport = bg_viewport
		LockTo = world
		pos = (-0.068807, 1.5990009, 5.7975965)
		Quat = (0.000506, 0.99942994, -0.017537998)
		FOV = 72.0
		Play_hold = 1
		interrupt_current
	}
	CreateScreenElement {
		type = TextElement
		parent = training_container
		id = lesson_title_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Hammer-On Lesson Complete!"
		scale = 1.0
		rgba = ($training_text_color)
	}
	UnPauseGame
	UnpauseGh3Sounds
	training_play_sound Sound = EN_Tutorial_4B_03_God Wait
	safe_destroy id = lesson_title_text
endscript

script training_4_4_explain 
	training_set_lesson_header_text \{text = "LESSON 4: PULL-OFF FINGERING"}
	training_set_lesson_header_body \{text = ""}
	training_show_lesson_header
endscript

script training_4_4_show_guitar 
	CreateScreenElement {
		parent = training_container
		type = SpriteElement
		id = guitar_sprite
		just = [center center]
		texture = training_guitar
		pos = (630.0, 400.0)
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = (0.4, 0.4)
		z_priority = 4
	}
	training_create_fret_finger_sprites
	pose_fret_fingers color = none
	training_create_strum_sprites
	pose_strum_fingers pos = middle
	training_play_sound Sound = EN_Tutorial_4D_01_LOU
	Wait 15 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 4.9500003 pos = (420.0, 360.0) scale = 0.7
	training_add_arrow id = training_strum_arrow life = 3.5 pos = (850.0, 360.0) scale = 0.7
	pose_fret_fingers color = Yellow
	Wait 1.0 seconds ignoreslomo
	pose_strum_fingers pos = down
	Wait 1.0 seconds ignoreslomo
	pose_strum_fingers pos = middle
	Wait 3 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 6.0 pos = (385.0, 360.0) scale = 0.7
	pose_fret_fingers color = red
	Wait 6 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 4.0 pos = (360.0, 360.0) scale = 0.7
	pose_fret_fingers color = green
	Wait 7 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 4.9500003 pos = (420.0, 360.0) scale = 0.7
	training_add_arrow id = training_strum_arrow life = 4.5 pos = (850.0, 360.0) scale = 0.7
	pose_fret_fingers color = green_red_yellow
	Wait 3.0 seconds ignoreslomo
	pose_strum_fingers pos = down
	Wait 1.0 seconds ignoreslomo
	pose_strum_fingers pos = middle
	Wait 1 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 2.0 pos = (385.0, 360.0) scale = 0.7
	pose_fret_fingers color = green_red
	Wait 2 seconds ignoreslomo
	training_add_arrow id = training_arrow life = 3.0 pos = (360.0, 360.0) scale = 0.7
	pose_fret_fingers color = green
	Wait 3 seconds ignoreslomo
	training_wait_for_sound Sound = EN_Tutorial_4D_01_LOU
endscript

script training_4_4_zoom_guitar 
	training_set_lesson_header_body text = "1. Play Yellow normally (strum)\\n2. Pull-off red (no strum)\\n3. Pull-off green (no strum)"
	training_show_lesson_header
	training_set_task_header_body text = "Hit 3 pull-off sequences to continue"
	training_show_task_header
	hide_strum_fingers
	hide_fret_fingers
	if ScreenElementExists id = guitar_sprite
		guitar_sprite :DoMorph scale = (1.0, 1.0) pos = (1100.0, 400.0) time = 0.75
	endif
	Wait 1 seconds ignoreslomo
endscript
training_pulloffs_played = 0

script training_4_4_wait_for_pulloff_complete 
	if ScreenElementExists id = menu_tutorial
		LaunchEvent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	printf channel = hammeron "training_4_2_wait_for_pullofff_complete..."
	event_handlers = [
		{pad_up training_pulloff_strummed_guitar}
		{pad_down training_pulloff_strummed_guitar}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	change LESSON_COMPLETE = 0
	change training_pulloffs_played = 0
	change notes_played = 0
	spawnscriptnow training_watch_buttons id = training_spawned_script
	begin
	if ($LESSON_COMPLETE = 1)
		break
	endif
	Wait 1 gameframe
	repeat
	LaunchEvent type = unfocus target = menu_tutorial
	destroy_menu menu_id = menu_tutorial
	create_training_pause_handler
	KillSpawnedScript name = training_watch_buttons
	hide_pressed_notes
	Wait 1 seconds ignoreslomo
	safe_destroy id = guitar_sprite
	training_destroy_fret_finger_sprites
	training_destory_strum_sprites
endscript

script training_pulloff_strummed_guitar 
	printf \{channel = hammeron
		"training_pulloff_strummed_guitar"}
	if ($LESSON_COMPLETE = 1)
		return
	endif
	printf \{channel = hammeron
		"Strummed guitar........."}
	KillSpawnedScript \{name = training_watch_for_pulloff}
	spawnscriptnow \{training_watch_for_pulloff
		id = training_spawned_script}
endscript

script training_watch_for_pulloff 
	printf channel = hammeron "training_watch_for_pulloff......"
	training_clear_notes_pressed
	training_count_buttons_pressed
	if (<notes_played> != 1)
		return
	endif
	GetHeldPattern controller = ($player1_status.controller) nobrokenstring
	check_button = 256
	if (<hold_pattern> && <check_button>)
		training_press_note note = 2
		training_hit_note note = 2
		spawnscriptnow Battle_SFX_Repair_Broken_String params = {num_strums = ($training_notes_strummed [0]) player_pan = 1 difficulty = easy}
		wait_time = 0
		begin
		GetHeldPattern controller = ($player1_status.controller) nobrokenstring
		check_button = 17
		if (<hold_pattern> && <check_button>)
			training_clear_notes_pressed
			printf channel = hammeron "failed..."
			return
		endif
		check_button = 4096
		if (<hold_pattern> && <check_button>)
			check_button = 256
			if NOT (<hold_pattern> && <check_button>)
				break
			endif
		endif
		wait_time = (<wait_time> + 1)
		if (<wait_time> >= 60)
			printf channel = hammeron "times up..."
			training_clear_notes_pressed
			return
		endif
		Wait 1 gameframe
		repeat
		training_press_note note = 1
		training_hit_note note = 1
		spawnscriptnow Battle_SFX_Repair_Broken_String params = {num_strums = ($training_notes_strummed [0]) player_pan = 1 difficulty = easy}
		wait_time = 0
		begin
		GetHeldPattern controller = ($player1_status.controller) nobrokenstring
		check_button = 273
		if (<hold_pattern> && <check_button>)
			training_clear_notes_pressed
			printf channel = hammeron "failed..."
			return
		endif
		check_button = 65536
		if (<hold_pattern> && <check_button>)
			check_button = 4096
			if NOT (<hold_pattern> && <check_button>)
				break
			endif
		endif
		wait_time = (<wait_time> + 1)
		if (<wait_time> >= 60)
			training_clear_notes_pressed
			return
		endif
		Wait 1 gameframe
		repeat
		training_press_note note = 0
		training_hit_note note = 0
		training_hit_note note = 1
		training_hit_note note = 2
		spawnscriptnow Battle_SFX_Repair_Broken_String params = {num_strums = ($training_notes_strummed [0]) player_pan = 1 difficulty = easy}
		change training_pulloffs_played = ($training_pulloffs_played + 1)
		if ($training_pulloffs_played = 1)
			training_play_sound Sound = EN_Tutorial_LOU_Positive_02
		endif
		if ($training_pulloffs_played >= 3)
			change LESSON_COMPLETE = 1
		endif
		Wait 2 seconds ignoreslomo
		training_clear_notes_pressed
	endif
endscript

script training_4_4_complete_message 
	safe_destroy id = guitar_sprite
	training_hide_lesson_header
	training_hide_task_header
	training_clear_notes_pressed
	training_destroy_pressed_notes
	CreateScreenElement {
		type = TextElement
		parent = training_container
		id = lesson_title_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Pull-Off Lesson Complete!"
		scale = 1.0
		rgba = ($training_text_color)
	}
	training_play_sound Sound = EN_Tutorial_4D_02_LOU Wait
	DestroyScreenElement id = lesson_title_text
endscript

script training_4_4_end 
	KillSpawnedScript \{name = training_watch_buttons}
	safe_destroy \{id = guitar_sprite}
	training_destroy_pressed_notes
	training_destroy_fret_finger_sprites
	training_destory_strum_sprites
endscript

script training_4_5_start_gem_scroller 
	destroy_band
	training_set_lesson_header_text text = "LESSON 5: PULL-OFFS"
	training_set_lesson_header_body text = ""
	training_show_lesson_header
	change structurename = player1_status current_health = 1.0
	start_gem_scroller song_name = Tutorial_4E difficulty = medium difficulty2 = easy StartTime = 0 device_num = ($player1_status.controller) training_mode = 1
	KillSpawnedScript name = update_score_fast
	disable_pause
	change notes_hit = 0
	change training_pulloffs_played = 0
endscript

script training_4_5_explain 
	setslomo 0.0
	setslomo_song slomo = 0.0
	training_set_lesson_header_body text = "1. Play Yellow normally (strum)\\n2. Pull-off red (no strum)\\n3. Pull-off green (no strum)"
	training_show_lesson_header
	training_set_task_header_body text = "Hit 8 notes using pull-offs to continue"
	training_show_task_header
	training_play_sound Sound = EN_Tutorial_4E_01_LOU Wait
	setslomo 1.0
	setslomo_song slomo = 1.0
endscript

script training_4_5_wait_for_hammerons 
	if ScreenElementExists id = menu_tutorial
		LaunchEvent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	event_handlers = [
		{hit_notesp1 lesson5_pulloff_note}
		{song_wonp1 training_song_won}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	change training_pulloffs_played = 0
	change training_song_over = 0
	begin
	if ($training_song_over = 1)
		break
	endif
	if ($training_pulloffs_played >= 8)
		break
	endif
	Wait 1 gameframe
	repeat
	if ScreenElementExists id = menu_tutorial
		LaunchEvent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
		create_training_pause_handler
	endif
endscript

script lesson5_pulloff_note 
	if (<hammer_strum> = 1)
		change training_pulloffs_played = ($training_pulloffs_played + 1)
		FormatText TextName = notes_hit "Notes Hit %a / 8" a = ($training_pulloffs_played)
		if ScreenElementExists id = notes_hit_text
			DestroyScreenElement id = notes_hit_text
		endif
		CreateScreenElement {
			type = TextElement
			parent = training_container
			id = notes_hit_text
			just = [center center]
			pos = (640.0, 200.0)
			font = ($training_font)
			text = <notes_hit>
			scale = 1.0
			rgba = ($training_text_color)
		}
		if ($training_pulloffs_played = 1)
			training_play_sound Sound = EN_Tutorial_LOU_Positive_01
		endif
	endif
endscript

script training_4_5_complete_message 
	if ScreenElementExists id = notes_hit_text
		DestroyScreenElement id = notes_hit_text
	endif
	training_hide_lesson_header
	training_hide_task_header
	PauseGame
	PauseGh3Sounds
	KillCamAnim name = ch_view_cam
	kill_gem_scroller
	destroy_bg_viewport
	setup_bg_viewport
	PlayIGCCam {
		id = cs_view_cam_id
		name = ch_view_cam
		viewport = bg_viewport
		LockTo = world
		pos = (-0.068807, 1.5990009, 5.7975965)
		Quat = (0.000506, 0.99942994, -0.017537998)
		FOV = 72.0
		Play_hold = 1
		interrupt_current
	}
	CreateScreenElement {
		type = TextElement
		parent = training_container
		id = lesson_title_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Pull-Off Lesson Complete!"
		scale = 1.0
		rgba = ($training_text_color)
	}
	UnpauseGh3Sounds
	UnPauseGame
	training_play_sound Sound = EN_Tutorial_4E_02_LOU Wait
	DestroyScreenElement id = lesson_title_text
	CreateScreenElement {
		type = TextElement
		parent = training_container
		id = lesson_title_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Advance Techniques Tutorial Complete!"
		scale = 1.0
		rgba = ($training_text_color)
	}
	training_play_sound Sound = EN_Tutorial_4_Outro Wait
	DestroyScreenElement id = lesson_title_text
endscript
training_song_over = 0

script training_song_won 
	change \{training_song_over = 1}
endscript

script training_advanced_techniques_tutorial_1_end 
	training_kill_session
	if ScreenElementExists \{id = menu_tutorial}
		LaunchEvent \{type = unfocus
			target = menu_tutorial}
		destroy_menu \{menu_id = menu_tutorial}
	endif
	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				gh3_start_pressed
			}
		]
		replace_handlers}
	enable_pause
	ui_flow_manager_respond_to_action \{action = complete_tutorial}
endscript
