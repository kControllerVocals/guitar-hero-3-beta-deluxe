popup_warning_menu_font = fontgrid_title_gh3

script create_popup_warning_menu 
	printstruct <...>
	if NOT GotParam menu_pos
		menu_pos = (495.0, 465.0)
		if GotParam options
			GetArraySize <options>
			if (<array_size> = 1)
				menu_pos = (525.0, 465.0)
			endif
		endif
	endif
	new_menu scrollid = pu_warning_scroll vmenuid = pu_warning_vmenu menu_pos = <menu_pos> spacing = -15
	set_focus_color rgba = [130 0 0 250]
	set_unfocus_color rgba = [0 0 0 255]
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = popup_warning_container
		pos = (0.0, 0.0)
		just = [left top]
	}
	displaySprite {
		parent = popup_warning_container
		tex = brick_bg
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [center center]
		z = 96
	}
	offwhite = [223 223 223 255]
	z = 100
	displaySprite parent = popup_warning_container tex = Dialog_Title_BG flip_v pos = (416.0, 100.0) dims = (224.0, 224.0) z = <z>
	displaySprite parent = popup_warning_container tex = Dialog_Title_BG pos = (640.0, 100.0) dims = (224.0, 224.0) z = <z>
	if GotParam options
		dims = (404.5, 80.0)
		if GotParam dialog_dims
			<dims> = <dialog_dims>
		endif
		pos = (640.0, 470.0)
		if GotParam dialog_pos
			<pos> = <dialog_pos>
		endif
		displaySprite parent = popup_warning_container tex = dialog_bg pos = <pos> just = [center top] dims = <dims> z = <z>
		bottom_pos = ((<pos>.(1.0, 0.0)) * (1.0, 0.0) + (0.0, 1.0) * ((<pos>.(0.0, 1.0)) + (<dims>.(0.0, 1.0))))
		displaySprite parent = popup_warning_container tex = dialog_bg flip_h pos = <bottom_pos> just = [center top] dims = <dims> z = <z>
		displaySprite id = hi_right parent = popup_warning_container tex = Dialog_Highlight pos = (770.0, 533.0) z = (<z> + 0.3)
		displaySprite id = hi_left parent = popup_warning_container tex = Dialog_Highlight flip_v pos = (500.0, 533.0) z = (<z> + 0.3)
	endif
	create_pause_menu_frame z = (<z> - 4)
	create_popup_warning_text <...>
	if GotParam options
		create_popup_warning_menu_options <...>
	endif
endscript

script destroy_popup_warning_menu 
	destroy_pause_menu_frame
	destroy_menu_backdrop
	destroy_menu \{menu_id = pu_warning_scroll}
	destroy_menu \{menu_id = popup_warning_container}
endscript

script create_popup_warning_text 
	if NOT GotParam title
		title = "WARNING"
	endif
	if NOT GotParam title_props
		title_props = {empty}
	endif
	CreateScreenElement {
		type = TextElement
		font = ($popup_warning_menu_font)
		text = <title>
		just = [center center]
		pos = (640.0, 220.0)
		scale = 1.3
		parent = popup_warning_container
		rgba = [200 200 200 255]
		shadow
		shadow_offs = (4.0, 4.0)
		shadow_rgba = [0 0 0 255]
		z_priority = (<z> + 2)
		<title_props>
	}
	if GotParam textblock
		CreateScreenElement {
			type = TextBlockElement
			font = ($popup_warning_menu_font)
			just = [center center]
			pos = (640.0, 375.0)
			dims = (700.0, 400.0)
			scale = 0.6
			parent = popup_warning_container
			rgba = [210 130 0 250]
			shadow
			shadow_offs = (5.0, 5.0)
			shadow_rgba = [0 0 0 255]
			z_priority = (<z> + 2)
			<textblock>
		}
	endif
	if GotParam TextElement
		CreateScreenElement {
			type = TextElement
			font = ($popup_warning_menu_font)
			just = [center center]
			pos = (640.0, 430.0)
			scale = 0.85
			parent = popup_warning_container
			rgba = [210 130 0 250]
			shadow
			shadow_offs = (5.0, 5.0)
			shadow_rgba = [0 0 0 255]
			z_priority = (<z> + 2)
			<TextElement>
		}
	endif
endscript

script create_popup_warning_menu_options 
	GetArraySize <options>
	0xf8c9b694 = 0x3bcc40e0
	if (<array_size> = 1)
		<0xf8c9b694> = retail_menu_focus
		if ScreenElementExists id = hi_left
			hi_left :SetProps alpha = 0
		endif
		if ScreenElementExists id = hi_right
			hi_right :SetProps alpha = 0
		endif
	endif
	CreateScreenElement {
		type = TextElement
		font = ($popup_warning_menu_font)
		parent = pu_warning_vmenu
		scale = (1.0, 1.0)
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus <0xf8c9b694>}
			{unfocus retail_menu_unfocus}
			{pad_choose (<options> [0].func)}
		]
		font_spacing = 0
		z_priority = (<z> + 1)
		(<options> [0])
	}
	0x3bcc40e0 id = <id>
	if (<array_size> = 2)
		CreateScreenElement {
			type = TextElement
			font = ($popup_warning_menu_font)
			parent = pu_warning_vmenu
			scale = (1.0, 1.0)
			rgba = ($menu_unfocus_color)
			event_handlers = [
				{focus 0x473645db}
				{unfocus retail_menu_unfocus}
				{pad_choose (<options> [1].func)}
			]
			font_spacing = 0
			z_priority = (<z> + 1)
			(<options> [1])
		}
	endif
endscript

script 0x3bcc40e0 
	retail_menu_focus <...>
	if NOT GotParam \{id}
		GetTags
	endif
	GetScreenElementDims id = <id>
	SetScreenElementProps id = hi_left pos = ((630.0, 494.0) - (<width> * (0.5, 0.0))) flip_v just = [right top]
	SetScreenElementProps id = hi_right pos = ((650.0, 494.0) + (<width> * (0.5, 0.0))) just = [left top]
endscript

script 0x473645db 
	retail_menu_focus <...>
	if NOT GotParam \{id}
		GetTags
	endif
	GetScreenElementDims id = <id>
	SetScreenElementProps id = hi_left pos = ((630.0, 540.0) - (<width> * (0.5, 0.0))) flip_v just = [right top]
	SetScreenElementProps id = hi_right pos = ((650.0, 540.0) + (<width> * (0.5, 0.0))) just = [left top]
endscript
