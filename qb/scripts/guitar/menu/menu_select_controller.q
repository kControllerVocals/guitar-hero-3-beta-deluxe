menu_select_controller_icon_positions = [
	{
		c = (370.0, 350.0)
		g = (370.0, 350.0)
		n = (616.0, 475.0)
	}
	{
		c = (900.0, 420.0)
		g = (900.0, 420.0)
		n = (926.0, 475.0)
	}
	{
		c = (510.0, 420.0)
		g = (510.0, 420.0)
	}
	{
		c = (590.0, 390.0)
		g = (590.0, 390.0)
	}
	{
		c = (670.0, 360.0)
		g = (670.0, 360.0)
	}
	{
		c = (750.0, 320.0)
		g = (750.0, 320.0)
	}
]
menu_select_num_controllers = 0
menu_select_controller_p1_controller_id = -1
menu_select_controller_p2_controller_id = -1
menu_select_controller_light = [
	180
	180
	180
	255
]
menu_select_controller_dark = [
	100
	100
	100
	255
]
menu_select_controller_sticks_big = (192.0, 192.0)
menu_select_controller_sticks_small = (160.0, 160.0)
menu_select_controller_guitar_big = (384.0, 192.0)
menu_select_controller_guitar_small = (320.0, 160.0)

script create_select_controller_menu 
	change p1_ready = 0
	change p2_ready = 0
	change menu_select_controller_p1_controller_id = -1
	change menu_select_controller_p2_controller_id = -1
	menu_font = text_a5
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = msc_container
		pos = (0.0, 0.0)
	}
	create_menu_backdrop texture = Controller_2p_BG
	displayText {
		parent = msc_container
		text = "Select Controller"
		pos = (690.0, 140.0)
		scale = 1.4
		just = [center center]
		rgba = [90 25 20 255]
		font = text_a10
		z = 100
		noshadow
	}
	CreateScreenElement {
		type = TextElement
		parent = msc_container
		text = "Move the desired controller"
		pos = (620.0, 570.0)
		scale = 0.7
		just = [center center]
		rgba = [90 25 20 255]
		font = text_a11
		z = 100
		shadow
		shadow_rgba = [225 220 175 255]
		shadow_offs = (2.0, 2.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = msc_container
		text = "to your side of the screen."
		pos = (620.0, 610.0)
		scale = 0.7
		just = [center center]
		rgba = [90 25 20 255]
		font = text_a11
		z = 100
		shadow
		shadow_rgba = [225 220 175 255]
		shadow_offs = (2.0, 2.0)
	}
	displaySprite parent = msc_container id = peasant_01 tex = controller_2p_LittleMan_01 rgba = [220 145 100 255] dims = (192.0, 192.0) pos = (60.0, 570.0) z = 10
	displaySprite parent = msc_container id = peasant_02 tex = controller_2p_LittleMan_02 rgba = [220 145 100 255] dims = (192.0, 192.0) pos = (160.0, 570.0) z = 10
	displaySprite parent = msc_container id = peasant_03 tex = controller_2p_LittleMan_04 rgba = [220 145 100 255] dims = (192.0, 192.0) pos = (240.0, 620.0) z = 10
	displaySprite parent = msc_container id = peasant_04 tex = controller_2p_LittleMan_03 rgba = [220 145 100 255] dims = (192.0, 192.0) pos = (320.0, 570.0) z = 10
	displaySprite parent = msc_container id = peasant_05 tex = controller_2p_LittleMan_01 rgba = [170 180 215 255] dims = (192.0, 192.0) pos = (760.0, 570.0) z = 10
	displaySprite parent = msc_container id = peasant_06 tex = controller_2p_LittleMan_02 rgba = [170 180 215 255] dims = (192.0, 192.0) pos = (860.0, 570.0) z = 10
	displaySprite parent = msc_container id = peasant_07 tex = controller_2p_LittleMan_03 rgba = [170 180 215 255] dims = (192.0, 192.0) pos = (940.0, 570.0) z = 10
	displaySprite parent = msc_container id = peasant_08 tex = controller_2p_LittleMan_04 rgba = [170 180 215 255] dims = (192.0, 192.0) pos = (1020.0, 570.0) z = 10
	CreateScreenElement {
		type = SpriteElement
		parent = msc_container
		id = arrow1
		texture = controller_2p_arrow
		rgba = [240 140 80 255]
		dims = (64.0, 128.0)
		pos = (450.0, 270.0)
		just = [left top]
		rot_angle = -20
	}
	<id> :SetTags old_pos = (450.0, 270.0)
	CreateScreenElement {
		type = SpriteElement
		parent = msc_container
		id = arrow2
		texture = controller_2p_arrow
		rgba = [130 90 205 255]
		dims = (64.0, 128.0)
		pos = (705.0, 445.0)
		just = [left top]
		flip_v
		flip_h
		rot_angle = -20
	}
	<id> :SetTags old_pos = (680.0, 420.0)
	spawnscriptnow cs_bounce_arrows
	spawnscriptnow jump_up_and_down_peasants
	add_user_control_helper text = "SELECT" button = green z = 100
	add_user_control_helper text = "BACK" button = red z = 100
	add_user_control_helper text = "UP/DOWN" button = strumbar z = 100
	create_ready_icons pos1 = (300.0, 450.0) pos2 = (835.0, 510.0)
	spawnscriptnow menu_select_controller_poll_for_controllers
endscript

script destroy_select_controller_menu 
	destroy_ready_icons
	change \{menu_select_num_controllers = 0}
	clean_up_user_control_helpers
	KillSpawnedScript \{name = cs_bounce_arrows}
	KillSpawnedScript \{name = jump_up_and_down_peasants}
	KillSpawnedScript \{name = menu_select_controller_poll_for_controllers}
	destroy_menu \{menu_id = msc_container}
	destroy_menu_backdrop
endscript

script cs_bounce_arrows 
	begin
	if ScreenElementExists id = arrow1
		arrow1 :GetTags
		doScreenElementMorph id = arrow1 pos = (<old_pos> + (15.0, 25.0)) time = 0.5 motion = ease_out
	endif
	if ScreenElementExists id = arrow2
		arrow2 :GetTags
		doScreenElementMorph id = arrow2 pos = (<old_pos>) time = 0.5 motion = ease_out
	endif
	Wait 0.5 seconds
	if ScreenElementExists id = arrow1
		arrow1 :GetTags
		doScreenElementMorph id = arrow1 pos = (<old_pos>) time = 0.5 motion = ease_in
	endif
	if ScreenElementExists id = arrow2
		arrow2 :GetTags
		doScreenElementMorph id = arrow2 pos = (<old_pos> + (15.0, 25.0)) time = 0.5 motion = ease_in
	endif
	Wait 0.5 seconds
	repeat
endscript

script jump_up_and_down_peasants 
	i = 1
	begin
	FormatText checksumname = peasant_id 'peasant_0%d' d = <i>
	if ScreenElementExists id = <peasant_id>
		GetScreenElementProps id = <peasant_id>
		GetRandomValue a = 0.05 b = 0.15 name = rand_time
		<peasant_id> :SetTags old_pos = <pos> rand_time = <rand_time>
	endif
	<i> = (<i> + 1)
	repeat 8
	begin
	<i> = 1
	begin
	FormatText checksumname = peasant_id 'peasant_0%d' d = <i>
	if ScreenElementExists id = <peasant_id>
		GetRandomValue a = 0 b = 42 name = pos_off_y Integer
		<peasant_id> :GetTags
		new_pos = (<old_pos> - (<pos_off_y> * (0.0, 1.0)))
		doScreenElementMorph id = <peasant_id> pos = <new_pos> time = <rand_time>
	endif
	<i> = (<i> + 1)
	repeat 8
	GetRandomValue a = 0.1 b = 0.2 name = rand_wait_time
	Wait <rand_wait_time> seconds
	<i> = 1
	begin
	FormatText checksumname = peasant_id 'peasant_0%d' d = <i>
	if ScreenElementExists id = <peasant_id>
		<peasant_id> :GetTags
		doScreenElementMorph id = <peasant_id> pos = <old_pos> time = <rand_time>
	endif
	<i> = (<i> + 1)
	repeat 8
	GetRandomValue a = 0.1 b = 0.2 name = rand_wait_time
	Wait <rand_wait_time> seconds
	repeat
endscript

script menu_select_controller_poll_for_controllers 
	begin
	active_controllers = [0 0 0 0]
	GetActiveControllers
	total_change = 0
	controller_index = 0
	begin
	if (<active_controllers> [<controller_index>] = 1)
		menu_select_controller_add_controllable_icon controller_index = <controller_index>
		<total_change> = (<total_change> + <changed>)
	else
		menu_select_controller_remove_controller_icon controller_index = <controller_index>
		<total_change> = (<total_change> + <changed>)
	endif
	<controller_index> = (<controller_index> + 1)
	repeat 4
	Wait 1 gameframe
	repeat
endscript

script menu_select_controller_add_controllable_icon controller_index = 0
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	if NOT ScreenElementExists id = <controller_icon_id>
		if IsGuitarController controller = <controller_index>
			c_texture = controller_2p_LesPaul
			c_pos = ($menu_select_controller_icon_positions [(<controller_index> + 2)].g)
		else
			GetPlatform
			switch <platform>
				case xenon
				c_texture = controller_2p_controller_XBOX
				case ps3
				c_texture = controller_2p_controller_PS3
				default
				ScriptAssert "Unrecognized platform for controller select"
			endswitch
			c_pos = ($menu_select_controller_icon_positions [(<controller_index> + 2)].c)
		endif
		CreateScreenElement {
			type = SpriteElement
			parent = msc_container
			id = <controller_icon_id>
			texture = <c_texture>
			rgba = [220 220 220 250]
			pos = <c_pos>
			dims = (128.0, 256.0)
			just = [center center]
			z_priority = 10
			rgba = <grey>
			event_handlers = [
				{pad_up menu_select_controller_move_up params = {controller_index = <controller_index>}}
				{pad_down menu_select_controller_move_down params = {controller_index = <controller_index>}}
				{pad_choose menu_select_controller_try_to_continue params = {controller_index = <controller_index>}}
				{pad_back menu_select_controller_go_back params = {controller_index = <controller_index>}}
			]
			exclusive_device = <controller_index>
		}
		<id> :SetProps scale = 0.5 relative_scale
		LaunchEvent type = focus target = <controller_icon_id>
		grey_out_controller controller_index = <controller_index>
		<controller_icon_id> :SetTags ready = no location = p0 port = <controller_index>
		change menu_select_num_controllers = ($menu_select_num_controllers + 1)
		return changed = 1
	endif
	return changed = 0
endscript

script menu_select_controller_leave_spot controller_index = 0
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	i = 1
	begin
	FormatText checksumname = controller_id 'menu_select_controller_p%d_controller_id' d = <i>
	if ($<controller_id> = <controller_index>)
		change globalname = <controller_id> newvalue = -1
		<controller_icon_id> :SetTags ready = no location = p0
		grey_out_controller controller_index = <controller_index>
		generic_menu_up_or_down_sound down
		return
	endif
	<i> = (<i> + 1)
	repeat 2
endscript

script menu_select_controller_get_spot controller_index = 0 Spot = p1
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	<controller_icon_id> :GetTags
	if (<Spot> = p1)
		if ($menu_select_controller_p1_controller_id = -1)
			change menu_select_controller_p1_controller_id = <controller_index>
			<controller_icon_id> :SetTags ready = Yes location = p1
			light_up_controller controller_index = <controller_index>
			generic_menu_up_or_down_sound up
		endif
	elseif (<Spot> = p2)
		if ($menu_select_controller_p2_controller_id = -1)
			change menu_select_controller_p2_controller_id = <controller_index>
			<controller_icon_id> :SetTags ready = Yes location = p2
			light_up_controller controller_index = <controller_index>
			generic_menu_up_or_down_sound down
		endif
	endif
endscript

script menu_select_controller_move_up \{controller_index = 0}
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	<controller_icon_id> :GetTags
	if (<location> = p2)
		if ($p2_ready)
			return
		endif
		menu_select_controller_leave_spot controller_index = <controller_index>
	elseif (<location> = p0)
		menu_select_controller_get_spot controller_index = <controller_index> Spot = p1
	endif
endscript

script menu_select_controller_move_down \{controller_index = 0}
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	<controller_icon_id> :GetTags
	if (<location> = p1)
		if NOT ($p1_ready = 0)
			return
		endif
		menu_select_controller_leave_spot controller_index = <controller_index>
	elseif (<location> = p0)
		menu_select_controller_get_spot controller_index = <controller_index> Spot = p2
	endif
endscript

script menu_select_controller_remove_controller_icon 
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	if ScreenElementExists id = <controller_icon_id>
		if ($menu_select_controller_p1_controller_id = <controller_index>)
			change \{menu_select_controller_p1_controller_id = -1}
		elseif ($menu_select_controller_p2_controller_id = <controller_index>)
			change \{menu_select_controller_p2_controller_id = -1}
		endif
		DestroyScreenElement id = <controller_icon_id>
		change menu_select_num_controllers = ($menu_select_num_controllers - 1)
		return \{changed = 1}
	endif
	return \{changed = 0}
endscript

script menu_select_controller_try_to_continue 
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	<controller_icon_id> :GetTags
	if (<location> = p1)
		if (<ready> = Yes)
			if ($p1_ready = 0)
				change p1_ready = 1
				SoundEvent event = ui_sfx_select
				drop_in_ready_sign player = 1
				change p1_ready = 2
			endif
			change player1_device = <controller_index>
		endif
	elseif (<location> = p2)
		if (<ready> = Yes)
			if ($p2_ready = 0)
				change p2_ready = 1
				SoundEvent event = ui_sfx_select
				drop_in_ready_sign player = 2
				change p2_ready = 2
			endif
			change player2_device = <controller_index>
		endif
	endif
	if (($p1_ready = 2) && ($p2_ready = 2))
		change p1_ready = 0
		change p2_ready = 0
		change structurename = player1_status controller = ($player1_device)
		change structurename = player2_status controller = ($player2_device)
		ui_flow_manager_respond_to_action action = continue
	endif
endscript

script menu_select_controller_go_back 
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	<controller_icon_id> :GetTags
	if (<location> = p1)
		if ($p1_ready = 2)
			change p1_ready = 0
			SoundEvent event = ui_sfx_select
			drop_out_ready_sign player = 1
		else
			ui_flow_manager_respond_to_action action = go_back
		endif
	elseif (<location> = p2)
		if ($p2_ready = 2)
			change p2_ready = 0
			SoundEvent event = Generic_Menu_Back_SFX
			drop_out_ready_sign player = 2
		else
			ui_flow_manager_respond_to_action action = go_back
		endif
	else
		ui_flow_manager_respond_to_action action = go_back
	endif
endscript

script grey_out_controller 
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	grey = [150 150 150 255]
	if ScreenElementExists id = <controller_icon_id>
		if IsGuitarController controller = <port>
			c_pos = ($menu_select_controller_icon_positions [(<controller_index> + 2)].g)
		else
			c_pos = ($menu_select_controller_icon_positions [(<controller_index> + 2)].c)
		endif
		doScreenElementMorph id = <controller_icon_id> pos = <c_pos> scale = 0.5 alpha = 0.75 time = 0.25 relative_scale motion = ease_in
		RunScriptOnScreenElement id = <controller_icon_id> controller_jiggle params = {<...>}
		SetScreenElementProps id = <controller_icon_id> rgba = <grey>
	endif
endscript

script light_up_controller 
	FormatText checksumname = controller_icon_id 'controller%d_icon' d = <controller_index>
	printf "Light up controller"
	white = [255 255 255 255]
	if ScreenElementExists id = <controller_icon_id>
		<controller_icon_id> :GetTags
		<controller_icon_id> :SetTags old_pos = <pos>
		<controller_icon_id> :GetTags
		index = 0
		if (<location> = p2)
			index = 1
		endif
		if IsGuitarController controller = <port>
			new_pos = ($menu_select_controller_icon_positions [<index>].g)
		else
			new_pos = ($menu_select_controller_icon_positions [<index>].c)
		endif
		doScreenElementMorph id = <controller_icon_id> pos = <new_pos> scale = 1.5 alpha = 1 time = 0.25 relative_scale motion = ease_in
		RunScriptOnScreenElement id = <controller_icon_id> controller_jiggle params = {<...>}
		SetScreenElementProps id = <controller_icon_id> rgba = <white>
	endif
endscript

script controller_jiggle 
	if NOT ScreenElementExists id = <controller_icon_id>
		return
	endif
	<controller_icon_id> :DoMorph pos = {(5.0, 0.0) relative} time = 0.1 motion = ease_in
	<controller_icon_id> :DoMorph pos = {(-10.0, 0.0) relative} time = 0.05
	<controller_icon_id> :DoMorph pos = {(5.0, 0.0) relative} time = 0.1 motion = ease_out
endscript
