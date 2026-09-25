info_text = [
	"Jump right into a Player match and rock the house against the first rocker available"
	"Jump right into a Ranked match and rock the house against the first rocker available"
	"Search for a specific type of online match"
	"Create and host your own online match"
	"Setup and make changes to your Quick Match Options and Highway Layout"
	"Check out who the best of the best are and see where you rank"
	"Check out the newest available downloads for Guitar Hero 3"
	"Be A Guitar Hero, and join the online community!"
	"Select 'Message Of The Day' to see the latest news in the Guitar Hero universe"
]
highlight_pos = [
	(460.0, 218.0)
	(460.0, 254.0)
	(460.0, 290.0)
	(460.0, 326.0)
	(460.0, 362.0)
	(460.0, 398.0)
	(460.0, 434.0)
	(460.0, 470.0)
	(460.0, 506.0)
]
online_main_menu_pos = (460.0, 110.0)
online_info_pane_pos = (850.0, 150.0)

script create_online_main_menu {
		menu_title = "Online Main Menu"
		menu_id = online_main_menu
		vmenu_id = online_main_vmenu
	}
	online_menu_init
	spawnscriptnow menu_music_on
	CreateScreenElement {
		type = VScrollingMenu
		parent = root_window
		id = <menu_id>
		just = [center top]
		dims = (400.0, 480.0)
		pos = (($online_main_menu_pos) + (0.0, 103.0))
		z_priority = 1
	}
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		id = <vmenu_id>
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		event_handlers = [
			{pad_back return_from_online_main_menu}
			{pad_back generic_menu_pad_back}
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
		]
	}
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = online_main_menu_container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = ContainerElement
		parent = online_main_menu_container
		id = online_main_menu_text_container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = online_info_pane_container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = ContainerElement
		parent = online_info_pane_container
		id = online_info_pane_text_container
		pos = (0.0, 0.0)
	}
	create_menu_backdrop texture = Online_Background
	displaySprite id = online_frame parent = online_main_menu_container tex = Online_Frame_Large pos = ($online_main_menu_pos) dims = (580.0, 480.0) just = [center top] z = 2
	displaySprite id = online_frame_crown parent = online_main_menu_container tex = online_frame_crown pos = (($online_main_menu_pos) + (0.0, -53.0)) dims = (256.0, 105.0) just = [center top] z = 3
	displaySprite id = highlight parent = online_main_menu_text_container tex = white pos = ($highlight_pos [0]) dims = (395.0, 40.0) rgba = ($online_light_blue) just = [center top] z = 3
	displaySprite id = 0x7c530f0d parent = online_main_menu_text_container tex = character_hub_hilite_bookend pos = (($highlight_pos [0]) + (-200.0, 18.0)) dims = (50.0, 50.0) rgba = ($online_light_blue) just = [center center] z = 3
	displaySprite id = 0xe55a5eb7 parent = online_main_menu_text_container tex = character_hub_hilite_bookend pos = (($highlight_pos [0]) + (213.0, 18.0)) dims = (50.0, 50.0) rgba = ($online_light_blue) just = [center center] z = 3
	displaySprite id = motd_top parent = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue) pos = ($online_info_pane_pos) dims = (320.0, 64.0) just = [center top] z = 5
	displaySprite id = motd_top_fill parent = online_info_pane_container tex = window_fill_cap rgba = [0 0 0 200] pos = ($online_info_pane_pos) dims = (320.0, 64.0) just = [center top] z = 5
	displaySprite id = motd_body parent = online_info_pane_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 64.0)) dims = (320.0, 256.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_body_fill parent = online_info_pane_container tex = window_fill_body_large rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 64.0)) dims = (320.0, 256.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_end parent = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 320.0)) dims = (320.0, 64.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_end_fill parent = online_info_pane_container tex = window_fill_cap rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 320.0)) dims = (320.0, 64.0) just = [center top] z = 5 flip_h
	displaySprite id = info_divide parent = online_info_pane_text_container tex = Char_Select_Frame_BG rgba = ($online_light_blue) pos = (($online_info_pane_pos) + (-5.0, 240.0)) dims = (320.0, 56.0) just = [center center] z = 6
	CreateScreenElement {
		type = TextElement
		parent = online_main_menu_text_container
		id = online_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_dark_purple)
		pos = (($online_main_menu_pos) + (0.0, 35.0))
		text = <menu_title>
		just = [center top]
		z_priority = 4.0
	}
	menu_item_count = 0
	if isXenon
		CreateScreenElement {
			type = TextElement
			parent = online_main_vmenu
			id = 0x1f54bdf5
			font = text_a4
			scale = 0.75
			rgba = ($online_light_blue)
			text = "Quick Match: Player Match"
			just = [left top]
			z_priority = 4.0
			event_handlers = [
				{focus 0x13df99da params = {this_id = 0x1f54bdf5 text_id = 0}}
				{unfocus retail_menu_unfocus}
				{pad_choose online_menu_select_quickmatch_player}
			]
		}
	else
		CreateScreenElement {
			type = TextElement
			parent = online_main_vmenu
			id = 0x1f54bdf5
			font = text_a4
			scale = 0.75
			rgba = ($online_light_blue)
			text = "Quick Match"
			just = [left top]
			z_priority = 4.0
			event_handlers = [
				{focus 0x13df99da params = {this_id = 0x1f54bdf5 text_id = 0}}
				{unfocus retail_menu_unfocus}
				{pad_choose online_menu_select_quickmatch_player}
			]
		}
	endif
	<id> :SetTags menu_item = <menu_item_count>
	<menu_item_count> = (<menu_item_count> + 1)
	if isXenon
		CreateScreenElement {
			type = TextElement
			parent = <vmenu_id>
			id = 0x19190a56
			font = text_a4
			scale = 0.75
			rgba = [180 230 250 250]
			text = "Quick Match: Ranked Match"
			just = [left top]
			z_priority = 4.0
			event_handlers = [
				{focus 0x13df99da params = {this_id = 0x19190a56 text_id = 1}}
				{unfocus retail_menu_unfocus}
				{pad_choose online_menu_select_quickmatch_ranked}
			]
		}
		<id> :SetTags menu_item = <menu_item_count>
		<menu_item_count> = (<menu_item_count> + 1)
	endif
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		id = custom_match
		font = text_a4
		scale = 0.75
		rgba = [180 230 250 250]
		text = "Custom Match"
		just = [left top]
		z_priority = 4.0
		event_handlers = [
			{focus 0x13df99da params = {this_id = custom_match text_id = 2}}
			{unfocus retail_menu_unfocus}
			{pad_choose online_menu_select_custom_match}
		]
	}
	<id> :SetTags menu_item = <menu_item_count>
	<menu_item_count> = (<menu_item_count> + 1)
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		id = create_match
		font = text_a4
		scale = 0.75
		rgba = [180 230 250 250]
		text = "Create Match"
		just = [left top]
		z_priority = 4.0
		event_handlers = [
			{focus 0x13df99da params = {this_id = create_match text_id = 3}}
			{unfocus retail_menu_unfocus}
			{pad_choose online_menu_select_create_match}
		]
	}
	<id> :SetTags menu_item = <menu_item_count>
	<menu_item_count> = (<menu_item_count> + 1)
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		id = player_options
		font = text_a4
		scale = 0.75
		rgba = [180 230 250 250]
		text = "Player Options"
		just = [left top]
		z_priority = 4.0
		event_handlers = [
			{focus 0x13df99da params = {this_id = player_options text_id = 4}}
			{unfocus retail_menu_unfocus}
			{pad_choose online_menu_select_options}
		]
	}
	<id> :SetTags menu_item = <menu_item_count>
	<menu_item_count> = (<menu_item_count> + 1)
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		id = leaderboards
		font = text_a4
		scale = 0.75
		rgba = [180 230 250 250]
		text = "Leaderboards"
		just = [left top]
		z_priority = 4.0
		event_handlers = [
			{focus 0x13df99da params = {this_id = leaderboards text_id = 5}}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_leaderboards}}
		]
	}
	<id> :SetTags menu_item = <menu_item_count>
	<menu_item_count> = (<menu_item_count> + 1)
	if isXenon
		CreateScreenElement {
			type = TextElement
			parent = <vmenu_id>
			id = 0x91814f8e
			font = text_a4
			scale = 0.75
			rgba = [180 230 250 250]
			text = "Downloadable Content"
			just = [left top]
			z_priority = 4.0
			event_handlers = [
				{focus 0x13df99da params = {this_id = 0x91814f8e text_id = 6}}
				{unfocus retail_menu_unfocus}
				{pad_choose online_select_downloads}
			]
		}
		<id> :SetTags menu_item = <menu_item_count>
		<menu_item_count> = (<menu_item_count> + 1)
	endif
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		id = 0x0d516bfb
		font = text_a4
		scale = 0.75
		rgba = [180 230 250 250]
		text = "www.guitarhero.com"
		just = [left top]
		z_priority = 4.0
		event_handlers = [
			{focus 0x13df99da params = {this_id = 0x0d516bfb text_id = 7}}
			{unfocus retail_menu_unfocus}
			{pad_choose online_menu_select_website}
		]
	}
	<id> :SetTags menu_item = <menu_item_count>
	<menu_item_count> = (<menu_item_count> + 1)
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		id = motd
		font = text_a4
		scale = 0.75
		rgba = [180 230 250 250]
		text = "Message Of The Day"
		just = [left top]
		z_priority = 4.0
		event_handlers = [
			{focus 0x13df99da params = {this_id = motd text_id = 8}}
			{unfocus retail_menu_unfocus}
			{pad_choose online_menu_select_motd}
		]
	}
	<id> :SetTags menu_item = <menu_item_count>
	<menu_item_count> = (<menu_item_count> + 1)
	CreateScreenElement {
		type = TextBlockElement
		parent = online_info_pane_text_container
		id = help_info_text_block
		font = text_a5
		scale = (0.75, 0.55)
		rgba = ($online_light_blue)
		text = ($info_text [0])
		just = [center top]
		internal_just = [center top]
		z_priority = 6.0
		pos = (($online_info_pane_pos) + (-4.0, 40.0))
		dims = (320.0, 370.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = online_info_pane_text_container
		id = motd_info_pane_title
		font = text_a4
		text = "Message of the Day"
		scale = 0.65000004
		rgba = ($online_light_blue)
		pos = (($online_info_pane_pos) + (0.0, 264.0))
		just = [center top]
		z_priority = 6.0
	}
	CreateScreenElement {
		type = WindowElement
		parent = online_info_pane_text_container
		id = motd_ticker_window
		pos = (($online_info_pane_pos) + (0.0, 312.0))
		dims = (248.0, 32.0)
		just = [center top]
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = motd_ticker_window
		id = motd_ticker_text_block
		just = [left top]
		internal_just = [left top]
		pos = (0.0, 0.0)
		scale = (0.75, 0.55)
		text = ""
		font = text_a5
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow get_motd_and_start_ticker
	set_focus_color rgba = ($online_dark_purple)
	set_unfocus_color rgba = ($online_light_blue)
	change user_control_pill_text_color = [0 0 0 255]
	change user_control_pill_color = [180 180 180 255]
	add_user_control_helper text = "SELECT" button = green z = 100
	add_user_control_helper text = "BACK" button = red z = 100
	add_user_control_helper text = "UP/DOWN" button = strumbar z = 100
	LaunchEvent type = focus target = <vmenu_id>
endscript

script destroy_online_main_menu 
	clean_up_user_control_helpers
	destroy_menu \{menu_id = online_main_menu}
	destroy_menu_backdrop
	if ScreenElementExists \{id = online_main_menu_container}
		DestroyScreenElement \{id = online_main_menu_container}
	endif
	if ScreenElementExists \{id = online_info_pane_container}
		DestroyScreenElement \{id = online_info_pane_container}
	endif
	KillSpawnedScript \{name = scroll_motd_ticker}
endscript

script get_motd_and_start_ticker 
	if ($retrieved_message_of_the_day = 0)
		NetSessionFunc \{obj = motd
			func = get_demonware_motd
			params = {
				callback = motd_callback
			}}
	else
		motd_ticker_text_block :SetProps text = ($message_of_the_day)
		spawnscriptnow \{scroll_motd_ticker
			params = {
				id = motd_ticker_text_block
			}}
	endif
endscript

script motd_callback 
	if GotParam \{motd_text}
		change \{retrieved_message_of_the_day = 1}
		change message_of_the_day = <motd_text>
		if ScreenElementExists \{id = motd_ticker_text_block}
			motd_ticker_text_block :SetProps text = ($message_of_the_day)
			spawnscriptnow \{scroll_motd_ticker
				params = {
					id = motd_ticker_text_block
				}}
		endif
	endif
endscript

script scroll_motd_ticker scroll_time = 20
	<end_pos> = (-1000.0, 0.0)
	<this_id> = <id>
	GetScreenElementChildren id = <this_id>
	if GotParam children
		begin
		begin
		Wait 2 seconds
		doScreenElementMorph id = <this_id> pos = <end_pos> time = <scroll_time>
		Wait 5 seconds
		GetScreenElementProps id = <this_id>
		SetScreenElementProps id = <this_id> pos = <pos>
		Wait 2.0 seconds
		<this_id> :DoMorph alpha = 0 time = 0.2
		<this_id> :SetProps pos = (0.0, 0.0)
		Wait 0.5 seconds
		<this_id> :DoMorph alpha = 1 time = 0.2
		break
		repeat
		repeat
	endif
endscript

script return_from_online_main_menu 
	printf \{"--- deinitializing network layer"}
	shut_down_net_play
	ui_flow_manager_respond_to_action \{action = go_back}
	enable_pause
endscript

script online_menu_select_quickmatch_player 
	change \{match_type = player}
	set_network_preferences
	ui_flow_manager_respond_to_action \{action = select_quickmatch_player}
endscript

script online_menu_select_quickmatch_ranked 
	change \{match_type = ranked}
	set_network_preferences
	ui_flow_manager_respond_to_action \{action = select_quickmatch_ranked}
endscript

script online_menu_select_custom_match 
	ui_flow_manager_respond_to_action \{action = select_custom_match
		create_params = {
			menu_type = custom_match
		}}
endscript

script online_menu_select_create_match 
	ui_flow_manager_respond_to_action \{action = select_create_match
		create_params = {
			menu_type = create_match
		}}
endscript

script online_menu_select_options 
	ui_flow_manager_respond_to_action \{action = select_online_options}
endscript

script lobby_connection_lost 
	printf \{"---lobby_connection_lost performing net cleanup"}
	quit_network_game
	setup_sessionfuncs
	ui_flow_manager_respond_to_action \{action = connection_lost}
endscript

script online_menu_select_website 
	create_link_text
	hide_unhide_menu_elements id = online_info_pane_container time = 0.2 hide
	Wait 0.1 seconds
	hide_unhide_menu_elements id = online_main_menu_text_container time = 0.2 hide
	hide_unhide_menu_elements id = online_main_vmenu time = 0.2 hide
	translate_and_scale_online_menu
	Wait 0.3 seconds
	if ScreenElementExists id = gh_link_container
		GetScreenElementChildren id = gh_link_container
		if GotParam children
			GetArraySize children
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 1.0 time = 0.2}
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
	event_handlers = [
		{pad_up 0x1600ab6b}
		{pad_down 0xf2a6a9d5}
		{pad_back online_menu_unselect_website}
	]
	ghlink_vmenu :SetProps event_handlers = <event_handlers>
endscript

script online_menu_unselect_website 
	if ScreenElementExists id = gh_link_container
		GetScreenElementChildren id = gh_link_container
		if GotParam children
			GetArraySize children
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 0.0 time = 0.2}
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
	Wait 0.3 seconds
	destroy_menu menu_id = ghlink
	if ScreenElementExists id = gh_link_container
		DestroyScreenElement id = gh_link_container
	endif
	translate_and_scale_online_menu revert
	hide_unhide_menu_elements id = online_main_menu_text_container time = 0.2
	hide_unhide_menu_elements id = online_main_vmenu time = 0.2
	Wait 0.1 seconds
	hide_unhide_menu_elements id = online_info_pane_container time = 0.2
	Wait 0.3 seconds
	LaunchEvent type = focus target = online_main_vmenu
endscript

script create_link_text 
	event_handlers = [
		{pad_up 0x1600ab6b}
		{pad_down 0xf2a6a9d5}
	]
	new_menu scrollid = ghlink vmenuid = ghlink_vmenu use_backdrop = (0) menu_pos = (320.0, 200.0) event_handlers = <event_handlers> default_colors = 0
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = gh_link_container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = gh_link_container
		id = gh_link_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_dark_purple)
		text = "www.guitarhero.com"
		just = [center top]
		pos = (640.0, 111.0)
		z_priority = 4.0
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a5
		scale = (0.75, 0.55)
		rgba = ($online_light_blue)
		text = "Ready to Be A Guitar Hero? \\nHere's how to link your stats to the \\nGuitarHero.com web community:"
		just = [center top]
		internal_just = [center top]
		z_priority = 6.0
		pos = (640.0, 170.0)
		dims = (950.0, 200.0)
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a5
		scale = (0.75, 0.55)
		rgba = ($online_light_blue)
		text = "- Go to www.guitarhero.com\\n- Create a New Account (or login if you have already registered)\\n- Click 'Link Account'\\n- Enter the following VIP Passcode"
		just = [center top]
		internal_just = [left top]
		z_priority = 6.0
		pos = (640.0, 260.0)
		dims = (1010.0, 600.0)
	}
	NetSessionFunc func = get_agora_token
	FormatText TextName = vip_code "%a" a = <token>
	CreateScreenElement {
		type = TextElement
		parent = gh_link_container
		font = text_a4
		scale = 1.25
		rgba = ($online_light_blue)
		text = <vip_code>
		just = [center top]
		z_priority = 6.0
		pos = (640.0, 370.0)
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a5
		scale = (0.75, 0.55)
		rgba = ($online_light_blue)
		text = "Your web account will now be linked to your in-game stats! On the web you can personalize your profile, browse the game's leaderboards, jam with an online band, collect groupies, and participate in tournaments!\\nBe A Guitar Hero, and join the online community!"
		just = [center top]
		internal_just = [left top]
		z_priority = 6.0
		pos = (648.0, 445.0)
		dims = (1010.0, 600.0)
	}
	if ScreenElementExists id = gh_link_container
		GetScreenElementChildren id = gh_link_container
		if GotParam children
			GetArraySize children
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 0.0}
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
	LaunchEvent type = unfocus target = online_main_vmenu
endscript

script online_menu_select_motd 
	create_motd_text
	hide_unhide_menu_elements id = online_main_menu_container time = 0.2 hide
	hide_unhide_menu_elements id = online_main_vmenu time = 0.2 hide
	Wait 0.1 seconds
	hide_unhide_menu_elements id = online_info_pane_text_container time = 0.2 hide
	translate_and_scale_info_pane
	Wait 0.3 seconds
	if ScreenElementExists id = MOTD_Container
		GetScreenElementChildren id = MOTD_Container
		if GotParam children
			GetArraySize children
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 1.0 time = 0.2}
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
	event_handlers = [
		{pad_up 0x1600ab6b}
		{pad_down 0xf2a6a9d5}
		{pad_back online_menu_unselect_motd}
	]
	motd_vmenu :SetProps event_handlers = <event_handlers>
endscript

script online_menu_unselect_motd 
	if ScreenElementExists id = MOTD_Container
		GetScreenElementChildren id = MOTD_Container
		if GotParam children
			GetArraySize children
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 0.0 time = 0.2}
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
	Wait 0.3 seconds
	destroy_menu menu_id = motd_scroller
	KillSpawnedScript name = scroll_motd_info
	if ScreenElementExists id = MOTD_Container
		DestroyScreenElement id = MOTD_Container
	endif
	translate_and_scale_info_pane revert
	hide_unhide_menu_elements id = online_info_pane_text_container time = 0.2
	Wait 0.1 seconds
	hide_unhide_menu_elements id = online_main_vmenu time = 0.2
	hide_unhide_menu_elements id = online_main_menu_container time = 0.2
	Wait 0.3 seconds
	LaunchEvent type = focus target = online_main_vmenu
endscript

script create_motd_text 
	event_handlers = [
		{pad_up 0x1600ab6b}
		{pad_down 0xf2a6a9d5}
	]
	new_menu scrollid = motd_scroller vmenuid = motd_vmenu use_backdrop = (0) menu_pos = (640.0, 0.0) event_handlers = <event_handlers> default_colors = 0
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = MOTD_Container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = MOTD_Container
		id = gh_link_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_light_blue)
		text = "Message Of The Day"
		just = [center top]
		pos = (640.0, 160.0)
		z_priority = 10.0
	}
	CreateScreenElement {
		type = WindowElement
		parent = MOTD_Container
		id = motd_info_scroll_window
		pos = (633.0, 220.0)
		dims = (500.0, 300.0)
		just = [center top]
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = motd_info_scroll_window
		id = motd_info_text_block
		just = [left top]
		internal_just = [left top]
		pos = (0.0, 0.0)
		scale = (0.75, 0.55)
		text = ($message_of_the_day)
		font = text_a5
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow scroll_motd_info params = {id = motd_info_text_block}
	if ScreenElementExists id = MOTD_Container
		GetScreenElementChildren id = MOTD_Container
		if GotParam children
			GetArraySize children
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 0.0}
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
	LaunchEvent type = unfocus target = online_main_vmenu
endscript

script scroll_motd_info scroll_time = 60
	<end_pos> = (0.0, -1000.0)
	<this_id> = <id>
	GetScreenElementChildren id = <this_id>
	if GotParam children
		GetArraySize (<children>)
		<line_nums> = <array_size>
	else
		return
	endif
	if (<line_nums> > 10)
		begin
		begin
		Wait 5 seconds
		doScreenElementMorph id = <this_id> pos = <end_pos> time = <scroll_time>
		Wait ((<line_nums> - 10) * 1.8) seconds
		GetScreenElementProps id = <this_id>
		SetScreenElementProps id = <this_id> pos = <pos>
		Wait 4.0 seconds
		<this_id> :DoMorph alpha = 0 time = 0.2
		<this_id> :SetProps pos = (0.0, 0.0)
		Wait 0.5 seconds
		<this_id> :DoMorph alpha = 1 time = 0.2
		break
		repeat
		repeat
	endif
endscript

script 0x1600ab6b 
	printf \{"---  mod_scroll_up"}
endscript

script 0xf2a6a9d5 
	printf \{"--- mod_scroll_down"}
endscript

script translate_and_scale_online_menu 
	if NOT GotParam revert
		RunScriptOnScreenElement id = online_frame doScreenElementMorph params = {id = online_frame pos = (($online_main_menu_pos) + (180.0, -35.0)) time = 0.2}
		RunScriptOnScreenElement id = online_frame_crown doScreenElementMorph params = {id = online_frame_crown pos = (($online_main_menu_pos) + (180.0, -88.0)) time = 0.2}
		RunScriptOnScreenElement id = online_frame scale_element_to_size params = {id = online_frame target_width = 680 target_height = 500 time = 0.2}
	else
		RunScriptOnScreenElement id = online_frame doScreenElementMorph params = {id = online_frame pos = ($online_main_menu_pos) time = 0.2}
		RunScriptOnScreenElement id = online_frame_crown doScreenElementMorph params = {id = online_frame_crown pos = (($online_main_menu_pos) + (0.0, -53.0)) time = 0.2}
		RunScriptOnScreenElement id = online_frame scale_element_to_size params = {id = online_frame target_width = 680 target_height = 500 time = 0.2}
	endif
endscript

script translate_and_scale_info_pane 
	if NOT GotParam revert
		RunScriptOnScreenElement id = motd_top doScreenElementMorph params = {id = motd_top pos = (($online_info_pane_pos) + (-210.0, -32.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill doScreenElementMorph params = {id = motd_top_fill pos = (($online_info_pane_pos) + (-210.0, -32.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body doScreenElementMorph params = {id = motd_body pos = (($online_info_pane_pos) + (-210.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill doScreenElementMorph params = {id = motd_body_fill pos = (($online_info_pane_pos) + (-210.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end doScreenElementMorph params = {id = motd_end pos = (($online_info_pane_pos) + (-210.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill doScreenElementMorph params = {id = motd_end_fill pos = (($online_info_pane_pos) + (-210.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_top scale_element_to_size params = {id = motd_top target_width = 800 target_height = 96 time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill scale_element_to_size params = {id = motd_top_fill target_width = 800 target_height = 96 time = 0.2}
		RunScriptOnScreenElement id = motd_body scale_element_to_size params = {id = motd_body target_width = 800 target_height = 256 time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill scale_element_to_size params = {id = motd_body_fill target_width = 800 target_height = 256 time = 0.2}
		RunScriptOnScreenElement id = motd_end scale_element_to_size params = {id = motd_end target_width = 800 target_height = 96 time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill scale_element_to_size params = {id = motd_end_fill target_width = 800 target_height = 96 time = 0.2}
	else
		RunScriptOnScreenElement id = motd_top doScreenElementMorph params = {id = motd_top pos = ($online_info_pane_pos) time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill doScreenElementMorph params = {id = motd_top_fill pos = ($online_info_pane_pos) time = 0.2}
		RunScriptOnScreenElement id = motd_body doScreenElementMorph params = {id = motd_body pos = (($online_info_pane_pos) + (0.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill doScreenElementMorph params = {id = motd_body_fill pos = (($online_info_pane_pos) + (0.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end doScreenElementMorph params = {id = motd_end pos = (($online_info_pane_pos) + (0.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill doScreenElementMorph params = {id = motd_end_fill pos = (($online_info_pane_pos) + (0.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_top scale_element_to_size params = {id = motd_top target_width = 800 target_height = 96 time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill scale_element_to_size params = {id = motd_top_fill target_width = 800 target_height = 96 time = 0.2}
		RunScriptOnScreenElement id = motd_body scale_element_to_size params = {id = motd_body target_width = 800 target_height = 256 time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill scale_element_to_size params = {id = motd_body_fill target_width = 800 target_height = 256 time = 0.2}
		RunScriptOnScreenElement id = motd_end scale_element_to_size params = {id = motd_end target_width = 800 target_height = 96 time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill scale_element_to_size params = {id = motd_end_fill target_width = 800 target_height = 96 time = 0.2}
	endif
endscript

script hide_unhide_menu_elements {time = 0.0}
	if ScreenElementExists id = <id>
		GetScreenElementChildren id = <id>
		if GotParam children
			GetArraySize children
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				if GotParam hide
					RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 0.0 time = <time>}
				else
					RunScriptOnScreenElement id = (<children> [<i>]) doScreenElementMorph params = {id = (<children> [<i>]) alpha = 1.0 time = <time>}
				endif
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
endscript

script create_net_play_song_menu 
	ui_print_gamertags \{pos1 = (320.0, 50.0)
		pos2 = (960.0, 50.0)
		dims = (350.0, 25.0)
		just1 = [
			center
			top
		]
		just2 = [
			center
			top
		]
		offscreen = 1}
endscript

script destroy_net_play_song_menu 
	destroy_gamertags
endscript

script 0x13df99da 
	retail_menu_focus
	if ScreenElementExists id = <this_id>
		<this_id> :GetTags
		highlight :SetProps pos = ($highlight_pos [<menu_item>])
		0x7c530f0d :SetProps pos = (($highlight_pos [<menu_item>]) + (-200.0, 18.0))
		0xe55a5eb7 :SetProps pos = (($highlight_pos [<menu_item>]) + (213.0, 18.0))
	endif
	if ScreenElementExists \{id = help_info_text_block}
		help_info_text_block :SetProps text = ($info_text [<text_id>])
	endif
endscript

script online_select_downloads 
	NetSessionFunc \{func = ShowMarketPlaceUI}
	wait_for_blade_complete
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	destroy_band
	Downloads_UnloadContent
	ui_flow_manager_respond_to_action \{action = select_downloadable_content}
endscript
