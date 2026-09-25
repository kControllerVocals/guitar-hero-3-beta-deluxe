
script timer_callback_script 
	if ($input_mode = Play)
		playback_timer
	endif
endscript

script script_callback_script 
	if NOT GameIsPaused
		if ($input_mode = Play)
			0xccf79bcc
		endif
		0x42ed04ca
		if ($faceoff_enabled = 1)
			0x121ac694
			0x4e4153f2
		endif
		if (($boss_battle = 1) || ($new_net_logic))
			SetInput controller = ($boss_controller) pattern = ($boss_pattern) strum = ($boss_strum)
			change boss_strum = 0
		endif
	endif
	if ($player1_status.bot_play = 1)
		SetInput controller = ($player1_status.controller) pattern = ($player1_status.bot_pattern) strum = ($player1_status.bot_strum)
		change structurename = player1_status bot_strum = 0
	endif
	if ($player2_status.bot_play = 1)
		SetInput controller = ($player2_status.controller) pattern = ($player2_status.bot_pattern) strum = ($player2_status.bot_strum)
		change structurename = player2_status bot_strum = 0
	endif
	if ($show_gpu_time = 1)
		if NOT ScreenElementExists id = 0x03e7da2e
			CreateScreenElement {
				type = TextElement
				parent = root_window
				id = 0x03e7da2e
				font = debug
				pos = (240.0, 652.0)
				just = [left bottom]
				scale = 0.75
				rgba = [210 210 210 250]
				text = "16.66667ms"
				z_priority = 100.0
				alpha = 1
			}
		endif
		if NOT ScreenElementExists id = 0x72c2acfd
			CreateScreenElement {
				type = TextElement
				parent = root_window
				id = 0x72c2acfd
				font = debug
				pos = (240.0, 678.0)
				just = [left bottom]
				scale = 0.75
				rgba = [210 210 210 250]
				text = "16.66667ms"
				z_priority = 100.0
				alpha = 1
			}
		endif
		if NOT ScreenElementExists id = 0x476dd991
			CreateScreenElement {
				type = TextElement
				parent = root_window
				id = 0x476dd991
				font = debug
				pos = (240.0, 704.0)
				just = [left bottom]
				scale = 0.75
				rgba = [210 210 210 250]
				text = "16.66667ms"
				z_priority = 100.0
				alpha = 1
			}
		endif
		if IsPs3
			GetProfileData cpu = 2 name = gpu
		else
			GetProfileData cpu = 6 name = gpu
		endif
		milliseconds = (<microseconds> / 1000.0)
		if (<milliseconds> < 10.0)
			FormatText TextName = text "0%tms" t = <milliseconds>
		else
			FormatText TextName = text "%tms" t = <milliseconds>
		endif
		SetScreenElementProps id = 0x03e7da2e text = <text>
		if (<milliseconds> > 13.0)
			SetScreenElementProps id = 0x03e7da2e rgba = [210 0 0 250]
		else
			SetScreenElementProps id = 0x03e7da2e rgba = [210 210 210 250]
		endif
		milliseconds = (<max_microseconds> / 1000.0)
		if (<milliseconds> < 10.0)
			FormatText TextName = text "0%tms" t = <milliseconds>
		else
			FormatText TextName = text "%tms" t = <milliseconds>
		endif
		SetScreenElementProps id = 0x72c2acfd text = <text>
		if (<milliseconds> > 13.0)
			SetScreenElementProps id = 0x72c2acfd rgba = [210 0 0 250]
		else
			SetScreenElementProps id = 0x72c2acfd rgba = [210 210 210 250]
		endif
		milliseconds = (<max_ever_microseconds> / 1000.0)
		if (<milliseconds> < 10.0)
			FormatText TextName = text "0%tms" t = <milliseconds>
		else
			FormatText TextName = text "%tms" t = <milliseconds>
		endif
		SetScreenElementProps id = 0x476dd991 text = <text>
		if (<milliseconds> > 13.0)
			SetScreenElementProps id = 0x476dd991 rgba = [210 0 0 250]
		else
			SetScreenElementProps id = 0x476dd991 rgba = [210 210 210 250]
		endif
		doScreenElementMorph id = 0x03e7da2e alpha = 1
		doScreenElementMorph id = 0x72c2acfd alpha = 1
		doScreenElementMorph id = 0x476dd991 alpha = 1
	else
		if ScreenElementExists id = 0x03e7da2e
			doScreenElementMorph id = 0x03e7da2e alpha = 0
		endif
		if ScreenElementExists id = 0x72c2acfd
			doScreenElementMorph id = 0x72c2acfd alpha = 0
		endif
		if ScreenElementExists id = 0x476dd991
			doScreenElementMorph id = 0x476dd991 alpha = 0
		endif
	endif
	if ($show_cpu_time = 1)
		if NOT ScreenElementExists id = 0x87add4d4
			CreateScreenElement {
				type = TextElement
				parent = root_window
				id = 0x87add4d4
				font = debug
				pos = (920.0, 652.0)
				just = [left bottom]
				scale = 0.75
				rgba = [210 210 210 250]
				text = "16.66667ms"
				z_priority = 100.0
				alpha = 1
			}
		endif
		if NOT ScreenElementExists id = 0xf688a207
			CreateScreenElement {
				type = TextElement
				parent = root_window
				id = 0xf688a207
				font = debug
				pos = (920.0, 678.0)
				just = [left bottom]
				scale = 0.75
				rgba = [210 210 210 250]
				text = "16.66667ms"
				z_priority = 100.0
				alpha = 1
			}
		endif
		if NOT ScreenElementExists id = 0xc327d76b
			CreateScreenElement {
				type = TextElement
				parent = root_window
				id = 0xc327d76b
				font = debug
				pos = (920.0, 704.0)
				just = [left bottom]
				scale = 0.75
				rgba = [210 210 210 250]
				text = "16.66667ms"
				z_priority = 100.0
				alpha = 1
			}
		endif
		GetProfileData cpu = 0 name = main
		milliseconds = (<microseconds> / 1000.0)
		if (<milliseconds> < 10.0)
			FormatText TextName = text "0%tms" t = <milliseconds>
		else
			FormatText TextName = text "%tms" t = <milliseconds>
		endif
		SetScreenElementProps id = 0x87add4d4 text = <text>
		if (<milliseconds> > 16.0)
			SetScreenElementProps id = 0x87add4d4 rgba = [210 0 0 250]
		else
			SetScreenElementProps id = 0x87add4d4 rgba = [210 210 210 250]
		endif
		milliseconds = (<max_microseconds> / 1000.0)
		if (<milliseconds> < 10.0)
			FormatText TextName = text "0%tms" t = <milliseconds>
		else
			FormatText TextName = text "%tms" t = <milliseconds>
		endif
		SetScreenElementProps id = 0xf688a207 text = <text>
		if (<milliseconds> > 16.0)
			SetScreenElementProps id = 0xf688a207 rgba = [210 0 0 250]
		else
			SetScreenElementProps id = 0xf688a207 rgba = [210 210 210 250]
		endif
		milliseconds = (<max_ever_microseconds> / 1000.0)
		if (<milliseconds> < 10.0)
			FormatText TextName = text "0%tms" t = <milliseconds>
		else
			FormatText TextName = text "%tms" t = <milliseconds>
		endif
		SetScreenElementProps id = 0xc327d76b text = <text>
		if (<milliseconds> > 16.0)
			SetScreenElementProps id = 0xc327d76b rgba = [210 0 0 250]
		else
			SetScreenElementProps id = 0xc327d76b rgba = [210 210 210 250]
		endif
		doScreenElementMorph id = 0x87add4d4 alpha = 1
		doScreenElementMorph id = 0xf688a207 alpha = 1
		doScreenElementMorph id = 0xc327d76b alpha = 1
	else
		if ScreenElementExists id = 0x87add4d4
			doScreenElementMorph id = 0x87add4d4 alpha = 0
		endif
		if ScreenElementExists id = 0xf688a207
			doScreenElementMorph id = 0xf688a207 alpha = 0
		endif
		if ScreenElementExists id = 0xc327d76b
			doScreenElementMorph id = 0xc327d76b alpha = 0
		endif
	endif
	guitar_tilt_debug_display
	updategemmovers
endscript

script script_postcallback_script 
	UpdateGuitarFuncs
	if NOT GameIsPaused
		GetDeltaTime
		Update2DParticleSystems delta_time = <delta_time>
		if ($output_gpu_log = 1)
			if IsPs3
				GetProfileData cpu = 2 name = gpu
			else
				GetProfileData cpu = 6 name = gpu
			endif
			milliseconds = (<microseconds> / 1000.0)
			GetSongTime
			FormatText TextName = text "GPU Time; %s; %m" s = <songtime> m = <milliseconds> DontAssertForChecksums
			TextOutput text = <text>
		endif
	endif
endscript
