
script create_join_server_menu 
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = joining_screen_container
		pos = (0.0, 0.0)
	}
	create_menu_backdrop
	CreateScreenElement {
		type = TextElement
		parent = joining_screen_container
		text = "JOINING GAME"
		just = [center center]
		pos = (640.0, 340.0)
		rot_angle = 0
		font = fontgrid_title_gh3
		scale = 3.0
		rgba = [210 210 210 250]
		shadow
		shadow_offs = (5.0, 5.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 2
	}
endscript

script destroy_join_server_menu 
	if ScreenElementExists \{id = joining_screen_container}
		DestroyScreenElement \{id = joining_screen_container}
	endif
	destroy_menu_backdrop
endscript

script create_joining_screen 
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = joining_screen_container
		pos = (0.0, 0.0)
	}
	create_menu_backdrop texture = Venue_BG
	CreateScreenElement {
		type = TextElement
		parent = joining_screen_container
		text = "JOINING GAME"
		just = [center center]
		pos = (640.0, 340.0)
		rot_angle = 0
		font = fontgrid_title_gh3
		scale = 2.0
		rgba = [210 210 210 250]
		shadow
		shadow_offs = (5.0, 5.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 2.0
	}
	CreateScreenElement {
		type = TextElement
		parent = joining_screen_container
		id = joining_dots_text
		font = text_a5
		scale = 2.0
		rgba = [210 210 210 250]
		text = ""
		just = [left top]
		z_priority = 2.0
		pos = (640.0, 450.0)
		shadow
		shadow_offs = (5.0, 5.0)
		shadow_rgba = [0 0 0 255]
	}
	if ScreenElementExists id = joining_dots_text
		RunScriptOnScreenElement id = joining_dots_text animate_dots params = {id = joining_dots_text}
	endif
endscript

script destroy_joining_screen 
	if ScreenElementExists \{id = joining_screen_container}
		DestroyScreenElement \{id = joining_screen_container}
	endif
	destroy_menu_backdrop
endscript
