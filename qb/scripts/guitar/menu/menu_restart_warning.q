
script create_restart_warning_menu player = 1
	disable_pause
	header_font = fontgrid_title_gh3
	menu_font = fontgrid_title_gh3
	warning_text_pos = (640.0, 177.0)
	0x4114c4fe = (650.0, 300.0)
	0xa7c40f91 = (640.0, 290.0)
	menu_pos = (540.0, 475.0)
	z = 100.0
	offwhite = [223 223 223 255]
	new_menu {
		scrollid = 0x6afb0c19
		vmenuid = 0x9d4cffd7
		use_backdrop = (0)
		menu_pos = <menu_pos>
		spacing = -20
		exclusive_device = ($last_start_pressed_device)
	}
	create_pause_menu_frame z = (<z> - 10)
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = 0x4a912c5b
		pos = (0.0, 0.0)
	}
	displaySprite parent = 0x4a912c5b tex = Dialog_Title_BG flip_v pos = (416.0, 100.0) dims = (224.0, 224.0) z = <z>
	displaySprite parent = 0x4a912c5b tex = Dialog_Title_BG pos = (639.0, 100.0) dims = (224.0, 224.0) z = <z>
	CreateScreenElement {
		type = TextElement
		parent = 0x4a912c5b
		font = <header_font>
		text = "WARNING"
		rgba = [223 223 223 250]
		just = [center top]
		scale = 1.3499999
		pos = <warning_text_pos>
		z_priority = (<z> + 0.1)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = 0x4a912c5b
		font = <menu_font>
		text = "You will lose all unsaved progress if you restart. Are you sure you want to restart this song?"
		rgba = [210 210 210 250]
		just = [center top]
		scale = (0.7, 0.6)
		pos = <0xa7c40f91>
		dims = <0x4114c4fe>
		z_priority = (<z> + 0.1)
	}
	displaySprite parent = 0x4a912c5b tex = dialog_bg pos = (480.0, 450.0) dims = (320.0, 80.0) z = <z>
	displaySprite parent = 0x4a912c5b tex = dialog_bg flip_h pos = (480.0, 530.0) dims = (320.0, 80.0) z = <z>
	displaySprite parent = 0x4a912c5b tex = white pos = (492.0, 517.0) scale = (75.0, 6.0) z = (<z> + 0.1) rgba = <offwhite>
	displaySprite parent = 0x4a912c5b tex = dialog_frame_joiner pos = (480.0, 510.0) rot_angle = 5 dims = (50.4, 48.0) z = (<z> + 0.2)
	displaySprite parent = 0x4a912c5b tex = dialog_frame_joiner pos = (750.0, 514.0) flip_v rot_angle = -5 dims = (50.4, 48.0) z = (<z> + 0.2)
	displaySprite id = hi_right parent = 0x4a912c5b tex = Dialog_Highlight pos = (770.0, 533.0) z = (<z> + 0.3)
	displaySprite id = hi_left parent = 0x4a912c5b tex = Dialog_Highlight flip_v pos = (500.0, 533.0) z = (<z> + 0.3)
	set_focus_color rgba = [180 50 50 255]
	set_unfocus_color rgba = [0 0 0 255]
	text_scale = (1.2, 1.25)
	CreateScreenElement {
		type = TextElement
		parent = 0x9d4cffd7
		font = <header_font>
		scale = <text_scale>
		rgba = [180 50 50 255]
		text = "CANCEL"
		just = [left top]
		z_priority = (<z> + 0.1)
		event_handlers = [
			{focus 0x0c0bcf24}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = go_back}}
		]
	}
	CreateScreenElement {
		type = TextElement
		parent = 0x9d4cffd7
		font = <header_font>
		scale = <text_scale>
		rgba = [0 0 0 255]
		text = "RESTART"
		just = [left top]
		z_priority = (<z> + 0.1)
		event_handlers = [
			{focus 0x348c2c66}
			{unfocus retail_menu_unfocus}
			{pad_choose restart_warning_select_restart params = {player = <player>}}
		]
	}
endscript

script destroy_restart_warning_menu 
	enable_pause
	destroy_menu \{menu_id = 0x6afb0c19}
	destroy_menu \{menu_id = 0x4a912c5b}
	destroy_pause_menu_frame
endscript

script restart_warning_select_restart \{player = 1}
	ui_flow_manager_respond_to_action action = continue create_params = {player = <player>}
endscript

script 0x0c0bcf24 
	retail_menu_focus
	if ScreenElementExists \{id = hi_left}
		if ScreenElementExists \{id = hi_right}
			SetScreenElementProps \{id = hi_left
				pos = (485.0, 480.0)
				flip_v}
			SetScreenElementProps \{id = hi_right
				pos = (730.0, 480.0)}
		endif
	endif
endscript

script 0x348c2c66 
	retail_menu_focus
	if ScreenElementExists \{id = hi_left}
		if ScreenElementExists \{id = hi_right}
			SetScreenElementProps \{id = hi_left
				pos = (475.0, 540.0)
				flip_v}
			SetScreenElementProps \{id = hi_right
				pos = (735.0, 540.0)}
		endif
	endif
endscript
