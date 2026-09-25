menu_choose_practice_speed_font = fontgrid_title_gh3

script create_choose_practice_speed_menu 
	new_menu scrollid = cps_scroll vmenuid = cps_vmenu name = "Select speed"
	text_params = {parent = cps_vmenu type = TextElement font = ($audio_settings_menu_font) rgba = ($menu_unfocus_color)}
	CreateScreenElement {
		type = ContainerElement
		id = cps_container
		parent = root_window
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = cps_container
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		rgba = [100 100 100 255]
		just = [left top]
	}
	CreateScreenElement {
		<text_params>
		text = "Full Speed"
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = full}}
		]
	}
	CreateScreenElement {
		<text_params>
		text = "Slow"
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = Slow}}
		]
	}
	CreateScreenElement {
		<text_params>
		text = "Slower"
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = slower}}
		]
	}
	CreateScreenElement {
		<text_params>
		text = "Slowest"
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = slowest}}
		]
	}
endscript

script destroy_choose_practice_speed_menu 
	destroy_menu \{menu_id = cps_container}
	destroy_menu \{menu_id = cps_scroll}
endscript

script menu_choose_practice_speed_set_speed Speed = full
	switch <Speed>
		case full
		change current_speedfactor = 1.0
		change structurename = PitchShiftSlow1 pitch = 1.0
		case Slow
		change current_speedfactor = 0.8
		change structurename = PitchShiftSlow1 pitch = 1.25
		case slower
		change current_speedfactor = 0.66666675
		change structurename = PitchShiftSlow1 pitch = 1.5
		case slowest
		change current_speedfactor = 0.5
		change structurename = PitchShiftSlow1 pitch = 2.0
	endswitch
	ui_flow_manager_respond_to_action action = continue device_num = (<device_num>)
endscript
