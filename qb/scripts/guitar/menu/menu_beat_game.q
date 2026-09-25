beat_game_title = "YOU BEAT GUITAR HERO III ON %d!"
beat_game_message = "Think you've got what it takes to really\\n blow their minds? Try this bad boy out on %n. There may be a reward waiting for you if you succeed. Pain, fame and glory await, li'l rocker."

script create_beat_game_menu 
	create_menu_backdrop texture = Beat_Game_BG
	menu_font = fontgrid_title_gh3
	get_current_band_info
	GetGlobalTags <band_info> param = name
	band_name = <name>
	FormatText TextName = band_name_text "%s" s = <band_name>
	difficulty_text = "EXPERT"
	next_difficulty_text = "Reality"
	difficulty = ($current_difficulty)
	switch (<difficulty>)
		case easy
		<difficulty_text> = "EASY"
		next_difficulty = medium
		<next_difficulty_text> = "Medium"
		case medium
		<difficulty_text> = "MEDIUM"
		next_difficulty = hard
		<next_difficulty_text> = "Hard"
		case hard
		<difficulty_text> = "HARD"
		next_difficulty = expert
		<next_difficulty_text> = "Expert"
	endswitch
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = beat_game_container
		pos = (0.0, 0.0)
		just = [left top]
	}
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_band_name
		just = [center top]
		font = <menu_font>
		text = <band_name_text>
		scale = 1.0
		rgba = [140 70 70 255]
		pos = (640.0, 360.0)
	}
	GetScreenElementDims id = bgs_band_name
	if (<width> > 300)
		fit_text_in_rectangle id = bgs_band_name dims = (700.0, 80.0) pos = (640.0, 360.0)
	endif
	FormatText TextName = title_text $beat_game_title d = <difficulty_text>
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_under_title
		just = [left top]
		font = <menu_font>
		text = <title_text>
		scale = 1.0
		rgba = [210 160 80 255]
	}
	fit_text_in_rectangle id = bgs_under_title dims = (700.0, 60.0) pos = (300.0, 435.0)
	FormatText TextName = motivation_text ($beat_game_message) n = <next_difficulty_text>
	CreateScreenElement {
		type = TextBlockElement
		parent = beat_game_container
		font = text_a4
		text = <motivation_text>
		dims = (1000.0, 700.0)
		pos = (640.0, 480.0)
		rgba = [250 245 145 255]
		just = [center top]
		internal_just = [center top]
		scale = 0.7
		z_priority = 3
	}
	button_font = buttonsxenon
	displaySprite id = 0x2e4b3fc6 parent = beat_game_container tex = Control_Pill_Fill pos = (550.0, 630.0) scale = 1.5 rgba = [180 180 205 255]
	displaySprite id = 0xaf999c30 parent = beat_game_container tex = Sponsored_Pill pos = (550.0, 650.0) scale = (1.5, 0.5) rgba = [0 0 0 255]
	CreateScreenElement {
		type = TextElement
		parent = 0x2e4b3fc6
		id = continue_button
		scale = 0.5
		pos = (10.0, 2.0)
		text = "\\b4"
		font = <button_font>
		rgba = [255 255 255 255]
		just = [left top]
		z_priority = 5
	}
	CreateScreenElement {
		type = TextElement
		parent = continue_button
		id = continue_text
		scale = 1.0
		pos = (40.0, 20.0)
		text = "CONTINUE"
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left center]
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action params = {action = continue}}
		]
		z_priority = 5
	}
	spawnscriptnow scroll_band_name params = {band_text = <band_name_text>}
	LaunchEvent type = focus target = continue_text
endscript

script destroy_beat_game_menu 
	destroy_menu \{menu_id = beat_game_container}
	destroy_menu_backdrop
	KillSpawnedScript \{name = scroll_band_name}
endscript

script scroll_band_name 
	displayText id = scrolling_bandname1 parent = beat_game_container pos = (0.0, 40.0) scale = 1 font = <menu_font> text = <band_text> rgba = [124 77 65 255]
	GetScreenElementDims id = scrolling_bandname1
	multi = (1280 / <width>)
	band_text_with_space = (<band_text> + " ")
	long_band_text = <band_text_with_space>
	begin
	<long_band_text> = (<long_band_text> + <band_text_with_space>)
	repeat <multi>
	SetScreenElementProps id = scrolling_bandname1 text = <long_band_text>
	displayText id = scrolling_bandname2 parent = beat_game_container scale = 1 font = <menu_font> text = <long_band_text> rgba = [124 77 65 255]
	GetScreenElementDims id = scrolling_bandname1
	SetScreenElementProps id = scrolling_bandname2 pos = (((1.0, 0.0) * <width>) + (0.0, 40.0))
	first = 1
	begin
	if (<first>)
		doScreenElementMorph id = scrolling_bandname1 pos = (((-1.0, 0.0) * <width>) + (0.0, 40.0)) time = 5
		doScreenElementMorph id = scrolling_bandname2 pos = (0.0, 40.0) time = 5
	else
		doScreenElementMorph id = scrolling_bandname2 pos = (((-1.0, 0.0) * <width>) + (0.0, 40.0)) time = 5
		doScreenElementMorph id = scrolling_bandname1 pos = (0.0, 40.0) time = 5
	endif
	Wait 5 seconds
	if (<first>)
		SetScreenElementProps id = scrolling_bandname1 pos = (((1.0, 0.0) * <width>) + (0.0, 40.0))
		SetScreenElementProps id = scrolling_bandname2 pos = (0.0, 40.0)
		<first> = 0
	else
		SetScreenElementProps id = scrolling_bandname2 pos = (((1.0, 0.0) * <width>) + (0.0, 40.0))
		SetScreenElementProps id = scrolling_bandname1 pos = (0.0, 40.0)
		<first> = 1
	endif
	repeat
endscript
