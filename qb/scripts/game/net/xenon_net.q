xboxlive_num_results = 0

script xboxlive_menu_optimatch_results_stop 
	NetSessionFunc \{obj = match
		func = stop_server_list}
	destroy_server_list_searching_dialog
	if GotParam \{xboxlive_num_results}
		xboxlive_menu_optimatch_results_end xboxlive_num_results = <xboxlive_num_results>
	else
		xboxlive_menu_optimatch_results_end \{xboxlive_num_results = 0}
	endif
endscript

script xboxlive_menu_optimatch_results_end 
	if GotParam \{xboxlive_num_results}
		change xboxlive_num_results = <xboxlive_num_results>
	endif
	printf "xboxlive_menu_optimatch_results_end : %d" d = ($xboxlive_num_results)
	if (($xboxlive_num_results) = 0)
		if CheckForSignIn
			create_server_list_create_match_dialog
		endif
	else
		SpawnScript \{xboxlive_menu_optimatch_results_wait_and_focus}
	endif
endscript

script xboxlive_menu_optimatch_results_wait_and_focus 
	Wait \{1
		gameframes}
	if ScreenElementExists \{id = search_results_vmenu}
		LaunchEvent \{type = focus
			target = search_results_vmenu}
		SetScreenElementProps \{id = search_results_vmenu
			enable_pad_handling}
	endif
endscript

script xboxlive_menu_optimatch_results_item_add 
	printf "--- xboxlive_menu_optimatch_results_item_add"
	printstruct <...>
	if (<num_players> < 2)
		change xboxlive_num_results = (($xboxlive_num_results) + 1)
		if NOT ScreenElementExists id = search_results_vmenu
			printf "Warning! tried to add a server when results menu not up"
			return
		endif
		if ($match_type = ranked)
			<host_text> = "HOST"
		else
			<host_text> = <server_name>
		endif
		CreateScreenElement {
			type = TextElement
			parent = search_results_vmenu
			id = <server_id>
			font = text_a5
			scale = 0.75
			rgba = [128 128 128 250]
			text = <host_text>
			just = [left top]
			internal_just = [left top]
			z_priority = 10.0
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
				{pad_choose net_choose_server params = {id = <server_id>}}
			]
		}
		CreateScreenElement {
			type = TextElement
			parent = <server_id>
			font = text_a5
			scale = 1.0
			rgba = [128 128 128 250]
			text = <level>
			pos = (400.0, 0.0)
			just = [left top]
			internal_just = [left top]
			z_priority = 10.0
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
			]
		}
		CreateScreenElement {
			type = TextElement
			parent = <server_id>
			font = text_a5
			scale = 1.0
			rgba = [128 128 128 250]
			text = <game_type>
			pos = (675.0, 0.0)
			just = [left top]
			internal_just = [left top]
			z_priority = 10.0
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
			]
		}
		FormatText TextName = text "%n" n = <qos>
		CreateScreenElement {
			type = TextElement
			parent = <server_id>
			font = text_a5
			scale = 0.75
			rgba = [128 128 128 250]
			text = <text>
			pos = (900.0, 0.0)
			just = [left top]
			internal_just = [left top]
			z_priority = 10.0
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
			]
		}
	endif
endscript
