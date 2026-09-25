
script create_press_any_button_menu 
	SoundEvent \{event = Menu_Guitar_Lick_SFX}
	spawnscriptnow \{menu_music_on
		params = {
			waitforguitarlick = 1
		}}
	create_menu_backdrop \{texture = bootup_copyright_bg}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = pab_container
		pos = (0.0, 0.0)}
	menu_press_any_button_create_obvious_text
	spawnscriptnow \{check_for_any_input}
	if NotCD
		if ($show_movies = 0)
			return
		endif
	endif
	spawnscriptnow \{attract_mode_spawner}
endscript

script destroy_press_any_button_menu 
	destroy_menu \{menu_id = pab_container}
	destroy_menu_backdrop
	KillSpawnedScript \{name = check_for_any_input}
	KillSpawnedScript \{name = attract_mode_spawner}
endscript

script attract_mode_spawner 
	if NotCD
		wait_time = 5
	else
		wait_time = 110
	endif
	begin
	printf "Wait_time for begin attract %i" i = <wait_time>
	if (<wait_time> = 0)
		break
	endif
	Wait \{1
		second}
	wait_time = (<wait_time> - 1)
	repeat
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = enter_attract_mode
			play_sound = 0
		}}
endscript
Attract_Mode_Info = [
	{
		level = load_z_artdeco
		song = paintitblack
		mode = p1_quickplay
		p1_character_id = Johnny
		p2_character_id = judy
		p1_instrument_id = Instrument_Les_Paul_Black
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
	}
	{
		level = load_z_dive
		song = evenflow
		mode = p2_faceoff
		p1_character_id = axel
		p2_character_id = Casey
		p1_instrument_id = Instrument_Les_Paul_Black
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
	}
	{
		level = load_z_wikker
		song = mynameisjonas
		mode = p2_faceoff
		p1_character_id = Xavier
		p2_character_id = judy
		p1_instrument_id = Instrument_Les_Paul_Black
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
	}
]
last_attract_mode = -1
is_attract_mode = 0

script create_attract_mode 
	change is_attract_mode = 1
	create_loading_screen
	kill_start_key_binding
	GetArraySize $Attract_Mode_Info
	if (<array_size> = 1)
		attract_mode_index = 0
	else
		if ($last_attract_mode >= 0)
			GetRandomValue name = attract_mode_index Integer a = 0 b = (<array_size> - 2)
			if (<attract_mode_index> >= $last_attract_mode)
				attract_mode_index = (<attract_mode_index> + 1)
			endif
		else
			GetRandomValue name = attract_mode_index Integer a = 0 b = (<array_size> - 1)
		endif
		change last_attract_mode = <attract_mode_index>
	endif
	AddParams ($Attract_Mode_Info [<attract_mode_index>])
	change structurename = player1_status bot_play = 1
	change structurename = player2_status bot_play = 1
	change current_level = <level>
	change game_mode = <mode>
	if ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff)
		change current_num_players = 2
	else
		change current_num_players = 1
	endif
	change structurename = player1_status character_id = <p1_character_id>
	change structurename = player2_status character_id = <p2_character_id>
	change structurename = player1_status instrument_id = <p1_instrument_id>
	change structurename = player2_status instrument_id = <p2_instrument_id>
	change is_shutdown_safe = 0
	UnPauseGame
	Load_Venue
	start_gem_scroller song_name = <song> difficulty = <p1_difficulty> difficulty2 = <p2_difficulty> StartTime = 0 device_num = ($player1_status.controller)
	create_attract_mode_text
	stoprendering
	destroy_loading_screen
	spawnscriptnow check_for_attract_mode_input
endscript

script create_attract_mode_text 
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = am_container
		pos = (0.0, 0.0)
	}
	text = "PRESS ANY BUTTON TO ROCK..."
	text_pos = (640.0, 537.0)
	CreateScreenElement {
		type = TextElement
		text = <text>
		pos = <text_pos>
		parent = am_container
		rgba = [220 220 220 255]
		font = fontgrid_title_gh3
		just = [center bottom]
		scale = 0.9
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [110 20 80 250]
	}
endscript

script destroy_attract_mode_text 
	destroy_menu \{menu_id = am_container}
endscript

script check_for_attract_mode_input 
	begin
	GetButtonsPressed
	if NOT (<makes> = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	begin
	if ($is_shutdown_safe = 1)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = exit_attract_mode
		}}
endscript

script destroy_attract_mode 
	PauseGame
	destroy_attract_mode_text
	KillSpawnedScript \{name = check_for_attract_mode_input}
	kill_gem_scroller
	change \{structurename = player1_status
		bot_play = 0}
	change \{structurename = player2_status
		bot_play = 0}
	UnPauseGame
	kill_start_key_binding
	change \{is_attract_mode = 0}
endscript

script check_for_any_input 
	begin
	GetButtonsPressed
	if (<makes> = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	begin
	GetButtonsPressed
	if NOT (<makes> = 0)
		spawnscriptnow ui_flow_manager_respond_to_action params = {action = continue flow_state_func_params = {device_num = <device_num>}}
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script menu_press_any_button_create_obvious_text 
	text = "PRESS ANY BUTTON TO ROCK..."
	text_pos = (670.0, 425.0)
	CreateScreenElement {
		type = TextBlockElement
		parent = pab_container
		font = text_a6
		text = <text>
		dims = (500.0, 200.0)
		pos = <text_pos>
		just = [left top]
		internal_just = [center top]
		rgba = [215 120 40 255]
		scale = 0.7
		allow_expansion
	}
endscript
