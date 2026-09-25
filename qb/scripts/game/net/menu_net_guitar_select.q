
script 0x0c7b6cff {
		menu_id = 0xc2521de6
		vmenu_id = 0x1e233ae4
		pad_back_script = 0x258665a1
		pos = ($menu_pos)
	}
	0x24000395 = [
		{pad_back <pad_back_script>}
	]
	new_menu scrollid = <menu_id> vmenuid = <vmenu_id> use_backdrop = (1) menu_pos = <pos> event_handlers = <0x24000395>
	instrument_type = guitar
	if (<instrument_type> = guitar)
		0x612c1ac9 = ($Free_Guitars)
		secret_instrument_array = ($Secret_Guitars)
	else
		0x612c1ac9 = ($Free_Basses)
		secret_instrument_array = ($Secret_Basses)
	endif
	GetArraySize (<0x612c1ac9>)
	array_entry = 0
	begin
	get_instrument_name_and_index id = (<0x612c1ac9> [<array_entry>])
	FormatText checksumname = temp_id 'guitar_number_%n' n = <instrument_index>
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		id = <temp_id>
		font = text_a1
		scale = 0.75
		rgba = [210 210 210 250]
		text = (<instrument_name>)
		just = [left top]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose 0x5275e0f6 params = {index = <instrument_index> 0xa35d171a = 0}}
		]
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	GetArraySize (<secret_instrument_array>)
	<array_entry> = 0
	begin
	GetGlobalTags ($Secret_Guitars [<array_entry>].id) param = unlocked
	if (<unlocked>)
		get_instrument_name_and_index id = (<secret_instrument_array> [<array_entry>].id)
		FormatText checksumname = temp_id 'secret_guitar_number_%n' n = <instrument_index>
		printf "mario"
		CreateScreenElement {
			type = TextElement
			parent = <vmenu_id>
			id = <temp_id>
			font = text_a1
			scale = 0.75
			rgba = [210 210 210 250]
			text = (<instrument_name>)
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose 0x5275e0f6 params = {index = <instrument_index> 0xa35d171a = 1}}
			]
		}
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	if (($0x3759a44c) > -1)
		0x1389e997 index = ($0x3759a44c) 0xa35d171a = ($0x978b81e0)
	endif
	if (($0x8d65c91e) > -1)
		0xb724ad39 index = ($0x8d65c91e) 0xa35d171a = ($0xc55ba73f)
	endif
	LaunchEvent type = focus target = <vmenu_id>
endscript

script 0xcc93ad74 
	destroy_menu \{menu_id = 0xc2521de6}
	destroy_menu_backdrop
endscript

script 0x258665a1 
	if (($0x8d65c91e) = -1)
		SendNetMessage \{type = guitar_selection
			guitar_index = -1
			selection_value = 0
			is_guitar = -1
			is_secret = -1
			menu_jump = -1}
		0xb0d4a366
		ui_flow_manager_respond_to_action \{action = go_back}
	else
		0xf0c169a8
	endif
endscript

script 0x1b2833ba 
	0xb0d4a366
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script 0x5275e0f6 
	if (($0x8d65c91e) = -1)
		SendNetMessage {
			type = guitar_selection
			guitar_index = <index>
			selection_value = 1
			is_guitar = 1
			is_secret = <0xa35d171a>
			menu_jump = 0
		}
		0xb724ad39 index = <index> 0xa35d171a = <0xa35d171a>
		change 0x8d65c91e = <index>
		change 0x978b81e0 = <0xa35d171a>
	endif
	0xed740105
endscript

script 0xf0c169a8 
	SendNetMessage {
		type = guitar_selection
		guitar_index = -1
		selection_value = -1
		is_guitar = -1
		is_secret = ($0x978b81e0)
		menu_jump = 0
	}
	0xa7fe971d 0xa35d171a = ($0x978b81e0)
	change \{0x8d65c91e = -1}
	change \{0x978b81e0 = 0}
endscript

script 0xee670e99 
	if (($0x3759a44c) = -1)
		if ScreenElementExists \{id = 0x1e233ae4}
			0x1389e997 index = <guitar_index> 0xa35d171a = <is_secret>
		endif
		change 0x3759a44c = <guitar_index>
		change 0xc55ba73f = <is_secret>
		0xed740105
	endif
endscript

script 0x05f93a2e 
	if ScreenElementExists \{id = 0x1e233ae4}
		0xe6cb275e 0xa35d171a = <is_secret>
	endif
	change \{0x3759a44c = -1}
	change \{0xc55ba73f = 0}
endscript

script 0x11a1149a 
	if (<menu_jump> = 1)
		if (($ui_flow_manager_state [0]) = 0x90517da6)
			if ($game_mode = p2_coop)
				ui_flow_manager_respond_to_action \{action = 0x52a29826}
			else
				ui_flow_manager_respond_to_action \{action = 0xe246d882}
			endif
		endif
	endif
	if (<menu_jump> = -1)
		if (($ui_flow_manager_state [0]) = 0x90517da6)
			0x1b2833ba
		endif
	endif
endscript

script 0xed740105 
	printf "check if both guitars are selected"
	if (($0x3759a44c) > -1)
		if (($0x8d65c91e) > -1)
			if ($game_mode = p2_coop)
				ui_flow_manager_respond_to_action action = 0x52a29826
			else
				ui_flow_manager_respond_to_action action = 0xe246d882
			endif
			SendNetMessage {
				type = guitar_selection
				guitar_index = -1
				selection_value = 0
				is_guitar = -1
				is_secret = -1
				menu_jump = 1
			}
		endif
	endif
endscript

script 0xb724ad39 
	if (<0xa35d171a> = 1)
		FormatText checksumname = temp_id 'secret_guitar_number_%n' n = <index>
	else
		FormatText checksumname = temp_id 'guitar_number_%n' n = <index>
	endif
	get_musician_instrument_struct index = <index>
	FormatText TextName = guitar_text "*** %s" s = (<info_struct>.name)
	<temp_id> :SetProps text = <guitar_text>
endscript

script 0xa7fe971d 
	if (<0xa35d171a> = 1)
		FormatText checksumname = temp_id 'secret_guitar_number_%n' n = ($0x8d65c91e)
	else
		FormatText checksumname = temp_id 'guitar_number_%n' n = ($0x8d65c91e)
	endif
	get_musician_instrument_struct index = ($0x8d65c91e)
	<temp_id> :SetProps text = (<info_struct>.name)
endscript

script 0x1389e997 
	if (<0xa35d171a> = 1)
		FormatText checksumname = temp_id 'secret_guitar_number_%n' n = <index>
	else
		FormatText checksumname = temp_id 'guitar_number_%n' n = <index>
	endif
	get_musician_instrument_struct index = <index>
	FormatText TextName = guitar_text "%s ***" s = (<info_struct>.name)
	<temp_id> :SetProps text = <guitar_text>
endscript

script 0xe6cb275e 
	if (<0xa35d171a> = 1)
		FormatText checksumname = temp_id 'secret_guitar_number_%n' n = ($0x3759a44c)
	else
		FormatText checksumname = temp_id 'guitar_number_%n' n = ($0x3759a44c)
	endif
	get_musician_instrument_struct index = ($0x3759a44c)
	<temp_id> :SetProps text = (<info_struct>.name)
endscript
