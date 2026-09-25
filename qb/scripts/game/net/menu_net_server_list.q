
script create_online_server_list 
	change xboxlive_num_results = 0
	0xf4eb5e26 = [
		{pad_up generic_menu_up_or_down_sound params = {up}}
		{pad_down generic_menu_up_or_down_sound params = {down}}
		{pad_back generic_menu_pad_back params = {callback = menu_flow_go_back}}
		{pad_square refresh_server_list}
	]
	new_menu scrollid = search_results_menu vmenuid = search_results_vmenu use_backdrop = (0) menu_pos = (250.0, 200.0) text_left event_handlers = <0xf4eb5e26>
	SetScreenElementProps id = search_results_vmenu disable_pad_handling
	LaunchEvent type = unfocus target = search_results_vmenu
	create_menu_backdrop texture = Online_Background
	NetSessionFunc obj = match func = stop_server_list
	NetSessionFunc obj = match func = free_server_list
	if (($ui_flow_manager_state [0]) = online_server_list_fs)
		CreateScreenElement {type = ContainerElement parent = root_window id = search_results_container pos = (0.0, 0.0)}
		if isXenon
			CreateScreenElement {
				type = TextElement
				parent = search_results_container
				font = fontgrid_title_gh3
				scale = 0.75
				rgba = [210 210 210 250]
				text = "GAMERTAG"
				just = [left top]
				pos = (250.0, 150.0)
				z_priority = 1.0
				shadow shadow_offs = (3.0, 3.0)
				shadow_rgba = [0 0 0 255]
			}
		else
			CreateScreenElement {type = TextElement
				parent = search_results_container
				font = fontgrid_title_gh3
				scale = 0.75
				rgba = [210 210 210 250]
				text = "NAME"
				just = [left top]
				pos = (250.0, 150.0)
				z_priority = 1.0
				shadow shadow_offs = (3.0, 3.0)
				shadow_rgba = [0 0 0 255]
			}
		endif
		CreateScreenElement {
			type = TextElement
			parent = search_results_container
			font = fontgrid_title_gh3
			scale = 0.75
			rgba = [210 210 210 250]
			text = "SONGS"
			just = [left top]
			pos = (550.0, 150.0)
			z_priority = 1.0
			shadow shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
		}
		CreateScreenElement {type = TextElement parent = search_results_container font = fontgrid_title_gh3 scale = 0.75 rgba = [210 210 210 250] text = "MODE" just = [left top] pos = (750.0, 150.0) z_priority = 1.0 shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}
		CreateScreenElement {type = TextElement parent = search_results_container font = fontgrid_title_gh3 scale = 0.75 rgba = [210 210 210 250] text = "SIGNAL" just = [left top] pos = (925.0, 150.0) z_priority = 1.0 shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}
		get_custom_match_search_params
		NetSessionFunc obj = match func = set_search_params params = <...>
		NetSessionFunc obj = match func = set_server_list_mode params = {optimatch}
		search_results_vmenu :SetTags search_type = custom_search
	else
		get_quick_match_search_params
		NetSessionFunc obj = match func = set_search_params params = <...>
		NetSessionFunc obj = match func = set_server_list_mode params = {quickmatch}
		search_results_vmenu :SetTags search_type = quickmatch_search
	endif
	NetSessionFunc obj = match func = start_server_list
	set_focus_color rgba = [255 255 255 250]
	set_unfocus_color rgba = [128 128 128 250]
	change user_control_pill_text_color = [0 0 0 255]
	change user_control_pill_color = [180 180 180 255]
	add_user_control_helper text = "SELECT" button = green z = 100
	add_user_control_helper text = "BACK" button = red z = 100
	add_user_control_helper text = "REFRESH" button = Blue z = 100
	add_user_control_helper text = "UP/DOWN" button = strumbar z = 100
	create_server_list_searching_dialog
endscript

script destroy_online_server_list 
	if ScreenElementExists \{id = searching_dialog_container}
		DestroyScreenElement \{id = searching_dialog_container}
	endif
	destroy_pause_menu_frame
	destroy_menu \{menu_id = server_list_searching_dialog_menu}
	if ScreenElementExists \{id = search_results_container}
		DestroyScreenElement \{id = search_results_container}
	endif
	clean_up_user_control_helpers
	destroy_menu \{menu_id = search_results_menu}
	destroy_menu_backdrop
endscript

script net_chosen_join_server 
	JoinServer <...>
	ui_flow_manager_respond_to_action \{action = select_server}
endscript

script net_choose_server 
	NetSessionFunc obj = match func = choose_server params = {id = <id>}
	ui_flow_manager_respond_to_action \{action = select_server}
endscript

script clear_search_list 
	if ScreenElementExists \{id = search_results_vmenu}
		GetScreenElementChildren \{id = search_results_vmenu}
		if GotParam \{children}
			GetArraySize \{children}
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				DestroyScreenElement id = (<children> [<i>])
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
endscript

script refresh_server_list 
	if NOT ScreenElementExists id = server_list_searching_dialog_menu
		if ScreenElementExists id = server_list_create_match_dialog_menu
			destroy_server_list_create_match_dialog
		endif
		search_results_vmenu :GetTags
		NetSessionFunc obj = match func = stop_server_list
		NetSessionFunc obj = match func = free_server_list
		clear_search_list
		if (<search_type> = custom_search)
			get_custom_match_search_params
			NetSessionFunc obj = match func = set_search_params params = <...>
			NetSessionFunc obj = match func = set_server_list_mode params = {optimatch}
		else
			get_quick_match_search_params
			NetSessionFunc obj = match func = set_search_params params = <...>
			NetSessionFunc obj = match func = set_server_list_mode params = {quickmatch}
		endif
		NetSessionFunc obj = match func = start_server_list
		create_server_list_searching_dialog
	endif
endscript

script create_server_list_searching_dialog {
		menu_id = server_list_searching_dialog_menu
		vmenu_id = server_list_searching_dialog_vmenu
		pad_back_script = searching_dialog_select_cancel
		pos = (600.0, 518.0)
	}
	event_handlers = [
		{pad_back <pad_back_script>}
		{pad_up generic_menu_up_or_down_sound params = {up}}
		{pad_down generic_menu_up_or_down_sound params = {down}}
	]
	new_menu scrollid = <menu_id> vmenuid = <vmenu_id> use_backdrop = (0) menu_pos = <pos> event_handlers = <event_handlers>
	create_pause_menu_frame z = 2
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = searching_dialog_container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = searching_dialog_container
		font = fontgrid_title_gh3
		scale = 1.0
		rgba = [210 210 210 250]
		text = "SEARCHING"
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 225.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = searching_dialog_container
		font = text_a5
		scale = 0.75
		rgba = [210 210 210 250]
		text = "Finding sessions"
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 350.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = searching_dialog_container
		id = dots_text
		font = text_a5
		scale = 0.75
		rgba = [210 210 210 250]
		text = ""
		just = [left top]
		z_priority = 10.0
		pos = (760.0, 350.0)
	}
	displaySprite parent = searching_dialog_container tex = Dialog_Title_BG dims = (240.0, 200.0) z = 9 pos = (640.0, 450.0) just = [right top] flip_v
	displaySprite parent = searching_dialog_container tex = Dialog_Title_BG dims = (240.0, 200.0) z = 9 pos = (640.0, 450.0) just = [left top]
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		font = fontgrid_title_gh3
		scale = 0.5
		rgba = [210 210 210 250]
		text = "STOP"
		just = [center top]
		z_priority = 10.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose searching_dialog_select_stop}
		]
	}
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		font = fontgrid_title_gh3
		scale = 0.5
		rgba = [128 128 128 250]
		text = "CANCEL"
		just = [center top]
		z_priority = 10.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose searching_dialog_select_cancel}
		]
	}
	set_focus_color rgba = [255 255 255 250]
	set_unfocus_color rgba = [128 128 128 250]
	if ScreenElementExists id = dots_text
		RunScriptOnScreenElement id = dots_text animate_dots params = {id = dots_text}
	endif
	LaunchEvent type = focus target = server_list_searching_dialog_vmenu
endscript

script destroy_server_list_searching_dialog 
	destroy_pause_menu_frame
	destroy_menu \{menu_id = server_list_searching_dialog_menu}
	if ScreenElementExists \{id = searching_dialog_container}
		DestroyScreenElement \{id = searching_dialog_container}
	endif
endscript

script searching_dialog_select_stop 
	xboxlive_menu_optimatch_results_stop
endscript

script searching_dialog_select_cancel 
	destroy_server_list_searching_dialog
	NetSessionFunc \{obj = match
		func = stop_server_list}
	NetSessionFunc \{obj = match
		func = free_server_list}
	ui_flow_manager_respond_to_action \{action = response_cancel_selected}
endscript

script create_server_list_create_match_dialog {
		menu_id = server_list_create_match_dialog_menu
		vmenu_id = server_list_create_match_dialog_vmenu
		pad_back_script = create_match_dialog_select_cancel
		pos = (560.0, 518.0)
	}
	event_handlers = [
		{pad_back <pad_back_script>}
		{pad_square refresh_server_list}
		{pad_up generic_menu_up_or_down_sound params = {up}}
		{pad_down generic_menu_up_or_down_sound params = {down}}
	]
	new_menu scrollid = <menu_id> vmenuid = <vmenu_id> use_backdrop = (0) menu_pos = <pos> event_handlers = <event_handlers>
	create_pause_menu_frame z = 2
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = create_match_dialog_container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = create_match_dialog_container
		font = fontgrid_title_gh3
		scale = 1.0
		rgba = [210 210 210 250]
		text = "SEARCHING"
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 225.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = create_match_dialog_container
		font = text_a5
		scale = 0.75
		rgba = [210 210 210 250]
		text = "No sessions are available."
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 300.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = create_match_dialog_container
		font = text_a5
		scale = 0.75
		rgba = [210 210 210 250]
		text = "Would you like to"
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 350.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = create_match_dialog_container
		font = text_a5
		scale = 0.75
		rgba = [210 210 210 250]
		text = "Create a Match?"
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 400.0)
	}
	displaySprite parent = create_match_dialog_container tex = Dialog_Title_BG dims = (240.0, 200.0) z = 9 pos = (640.0, 450.0) just = [right top] flip_v
	displaySprite parent = create_match_dialog_container tex = Dialog_Title_BG dims = (240.0, 200.0) z = 9 pos = (640.0, 450.0) just = [left top]
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		font = fontgrid_title_gh3
		scale = 0.5
		rgba = [210 210 210 250]
		text = "CREATE MATCH"
		just = [center top]
		z_priority = 10.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose create_match_dialog_select_create}
		]
	}
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		font = fontgrid_title_gh3
		scale = 0.5
		rgba = [128 128 128 250]
		text = "CANCEL"
		just = [center top]
		z_priority = 10.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose create_match_dialog_select_cancel}
		]
	}
	set_focus_color rgba = [255 255 255 250]
	set_unfocus_color rgba = [128 128 128 250]
	create_match_dialog_focus
endscript

script destroy_server_list_create_match_dialog 
	create_match_dialog_unfocus
	destroy_pause_menu_frame
	destroy_menu \{menu_id = server_list_create_match_dialog_menu}
	if ScreenElementExists \{id = create_match_dialog_container}
		DestroyScreenElement \{id = create_match_dialog_container}
	endif
endscript

script create_match_dialog_select_create 
	destroy_server_list_create_match_dialog
	ui_flow_manager_respond_to_action \{action = response_create_selected
		create_params = {
			menu_type = create_match
		}}
endscript

script create_match_dialog_select_cancel 
	destroy_server_list_create_match_dialog
	ui_flow_manager_respond_to_action \{action = response_cancel_selected}
endscript

script create_match_dialog_focus 
	LaunchEvent \{type = unfocus
		target = search_results_vmenu}
	LaunchEvent \{type = focus
		target = server_list_create_match_dialog_vmenu}
endscript

script create_match_dialog_unfocus 
	LaunchEvent \{type = unfocus
		target = server_list_create_match_dialog_vmenu}
	LaunchEvent \{type = focus
		target = search_results_vmenu}
endscript
dots_array = [
	" "
	"."
	". ."
	". . ."
]

script animate_dots 
	num_dots = 0
	begin
	FormatText TextName = new_text "%a" a = ($dots_array [<num_dots>])
	<id> :SetProps text = <new_text>
	if (<num_dots> = 3)
		<num_dots> = 0
	else
		<num_dots> = (<num_dots> + 1)
	endif
	Wait \{1
		second}
	repeat
endscript
